
import {BrowserRouter, Route, Routes} from 'react-router-dom';

import About from "./pages/About";
import Home from "./pages/Home";
import Quizzes from "./pages/Quizzes";
import Login from "./pages/Login";
import Register from "./pages/Register";
import Navbar from './components/Navbar'

import './App.css';
import Encyclopedia from './pages/Encyclopedia';
import Camellia from './pages/Camellia';
import Moderation from './pages/Moderation';
import Profile from './pages/Profile';

function App() {
  return (
      <BrowserRouter>
          <Navbar/>
          <Routes>
              <Route path="/" element={<Home />} />
              <Route path="/moderation" element={<Moderation />} />
              <Route path="/login" element={<Login />}/>
              <Route path="/quizzes" element={<Quizzes />}/>
              <Route path="/encyclopedia" element={<Encyclopedia />} />
              <Route path="/encyclopedia/camellia" element={<Camellia />} />
              <Route path="/register" element={<Register />}/>
              <Route path="/about" element={<About />}/>
              <Route path="/profile" element={<Profile />}/>
          </Routes>
      </BrowserRouter>
  );
}

export default App;
