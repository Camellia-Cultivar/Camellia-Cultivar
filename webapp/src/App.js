import logo from './logo.svg';
import './App.css';
import Navbar from './components/Navbar'
import {BrowserRouter, Route, Routes} from 'react-router-dom';
import About from "./pages/About";
import Home from "./pages/Home";

function App() {
  return (
      <BrowserRouter>
          <Navbar/>
          <Routes>
              <Route path="/" element={<Home />} />
              <Route path="/about-us" element={<About />}/>
          </Routes>
      </BrowserRouter>
  );
}

export default App;
