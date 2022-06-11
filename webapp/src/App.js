import { useEffect, useState } from 'react'
import { BrowserRouter, Route, Routes, useNavigate } from 'react-router-dom';
import { useDispatch, useSelector } from 'react-redux';
import axios from 'axios';

import './App.css';

import About from "./pages/About";
import Home from "./pages/Home";
import Quizzes from "./pages/Quizzes";
import Login from "./pages/Login";
import Register from "./pages/Register";
import Navbar from './components/Navbar'

import Encyclopedia from './pages/Encyclopedia';
import Camellia from './pages/Camellia';
import Moderation from './pages/Moderation';
import Profile from './pages/Profile';
import Verify from './pages/Verify';
import history from './utilities/history'
import { signIn, signOut, signedIn } from './redux/actions'


function App() {

    const navigate = useNavigate();
    const dispatch = useDispatch();
    const userDetails = useSelector(state => state.user);
    const [isMod, setIsMod] = useState(false);

    useEffect(() => {
        const listen = history.listen((location, action) => {
            fetchUser(true);
        })
        fetchUser(Object.keys(userDetails).length === 0);
        return listen;
    })

    const fetchUser = (secondFactor) => {
        const loggedInUser = localStorage.getItem("userToken");
        if (loggedInUser && secondFactor) {
            const user = JSON.parse(localStorage.getItem("userToken"));
            if (user.expiry > Date.now()) {
                Object.keys(userDetails).length === 0 && axios.get(`/api/users/${user.userId}`, {
                    headers: {
                        "Authorization": `Bearer ${user.loginToken}`,
                    }
                })
                    .then(function (response) {
                        console.log(response);
                        if (!response.data.verified) {
                            if (history.location.pathname !== '/verify')
                                navigate("/verify");
                        } else {
                            dispatch(signIn());
                            dispatch(signedIn(response.data));
                            Object.keys(userDetails).length === 0 && checkMod(user.userId, user.loginToken);
                        }

                    })
                    .catch(function (error) {
                        console.log(error);
                    });


                Object.keys(userDetails).length === 0 && checkMod(user.userId, user.loginToken);
            } else {
                localStorage.removeItem("userToken");
                dispatch(signOut());

            }

        }
    }

    const checkMod = (id, token) => {
        const options = {
            headers: {
                'Authorization': 'Bearer ' + token
            }
        }
        axios.get(`api/moderator/${id}`, options)
            .then(response => {
                setIsMod(response.status === 202)
            }).catch(err => {
                return;
            })
    }


    return (
        <>
            <Navbar />
            <Routes>
                <Route path="/" element={<Home />} />
                <Route path="/verify" element={<Verify />} />
                {isMod && <Route path="/moderation" element={<Moderation />} />}
                <Route path="/login" element={<Login />} />
                <Route path="/quizzes" element={<Quizzes />} />
                <Route path="/encyclopedia" element={<Encyclopedia />} >
                </Route>
                <Route path="/encyclopedia/:id" element={<Camellia />} />
                <Route path="/register" element={<Register />} />
                <Route path="/about" element={<About />} />
                <Route path="/profile" element={<Profile />} />
            </Routes>
        </>
    );
}

export default App;
