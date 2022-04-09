
import {BrowserRouter, Route, Routes} from 'react-router-dom';

import About from "./pages/About";
import Home from "./pages/Home";
import Login from "./pages/Login";
import Register from "./pages/Register";
import Navbar from './components/Navbar'

import './App.css';

function App() {
  return (
      <BrowserRouter>
          <Navbar/>
          <Routes>
              <Route path="/" element={<Home />} />
              <Route path="/login" element={<Login/>} />
              <Route path="/register" element={<Register />}/>
              <Route path="/about" element={<About />}/>
          </Routes>
      </BrowserRouter>
  );
}

export default App;
