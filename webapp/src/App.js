import { useEffect, useState } from 'react'
import { Route, Routes, } from 'react-router-dom';
import { useDispatch, useSelector } from 'react-redux';
import axios from 'axios';



import Home from "./pages/Home";
import Quizzes from "./pages/Quizzes";
import Login from "./pages/Login";
import Register from "./pages/Register";
import Navbar from './components/Navbar'

import Encyclopedia from './pages/Encyclopedia';
import Camellia from './pages/Camellia';
import Moderation from './pages/Moderation';
import Profile from './pages/Profile';
import history from './utilities/history'
import { signIn, signOut, signedIn, setMod } from './redux/actions'


function App() {

    const dispatch = useDispatch();
    const userDetails = useSelector(state => state.user);
    const [isMod, setIsMod] = useState(false);

    useEffect(() => {
        getTokenAvailability();
        const listen = history.listen((_location, _action) => {
            fetchUser();
        })
        fetchUser(Object.keys(userDetails).length === 0);
        return listen;
    })

    const fetchUser = (secondFactor=true) => {
        const loggedInUser = localStorage.getItem("userToken");
        if (loggedInUser && secondFactor) {
            const user = JSON.parse(localStorage.getItem("userToken"));
            axios.get(`/api/users/${user.userId}`, {
                headers: {
                    "Authorization": `Bearer ${user.loginToken}`,
                }
            })
                .then(function (response) {
                    dispatch(signIn());
                    dispatch(signedIn(response.data));

                })
                .catch(function (_error) {
                    if(_error.response.status === 403) {
                        localStorage.removeItem("userToken");
                        dispatch(signOut());
                        window.location.href = "/";
                    }
                });
            Object.keys(userDetails).length === 0 && checkMod(user.userId, user.loginToken);
        }
        
    }

    const getTokenAvailability = () => {
        const loggedInUser = localStorage.getItem("userToken");
        if (loggedInUser) {
            const user = JSON.parse(loggedInUser);
            if (user.expiry < Date.now()) {
                localStorage.removeItem("userToken");
                dispatch(signOut());
                window.location.href = "/";
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
                setIsMod(response.status === 202);
                dispatch(setMod());

            }).catch(_err => {
                return;
            })
    }


    return (
        <>
            <Navbar />
            <Routes>
                <Route path="/" element={<Home />} />
                {isMod && <Route path="/moderation" element={<Moderation />} />}
                <Route path="/login" element={<Login />} />
                <Route path="/quizzes" element={<Quizzes />} />
                <Route path="/encyclopedia" element={<Encyclopedia />} >
                </Route>
                <Route path="/encyclopedia/:id" element={<Camellia />} />
                <Route path="/register" element={<Register />} />
                <Route path="/profile" element={<Profile />} />
            </Routes>
        </>
    );
}

export default App;
