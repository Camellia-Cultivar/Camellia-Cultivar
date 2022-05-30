import React, { useState, useEffect } from 'react';
import { Link, NavLink, useNavigate } from 'react-router-dom';
import { useSelector } from 'react-redux';
import axios from 'axios';

const Navbar = () => {

    const [navbarOpen, setNavbarOpen] = useState(false)

    const isLogged = useSelector(state => state.isLogged)

    const user = useSelector(state => state.user)

    const handleToggle = () => {
        setNavbarOpen(!navbarOpen)
    }

    const closeMenu = () => {
        setNavbarOpen(false)
    }

    let activeLink = "block text-base py-5 px-3 lg:py-0.5 lg:px-0 lg:border-b-2 border-teal-400 bg-emerald-900/10 text-neutral-600 lg:text-white lg:bg-transparent";
    let link = "block text-base py-5 px-3 lg:py-0.5 lg:px-0 lg:border-b-2 border-transparent hover:border-white lg:hover:text-white";

    let openNavbar = "shadow-md lg:flex flex flex-col lg:gap-7 w-full justify-evenly text-base lg:text-stone-200 text-neutral-500 lg:flex-row lg:mt-0 lg:text-sm lg:font-medium";
    let closedNavbar = "hidden lg:flex gap-7 justify-evenly text-stone-200 flex-row mt-0 text-sm font-medium";


    let navigate = useNavigate();

    return (
        <div className="overflow-x-hidden sticky top-0 z-50">
            <nav className="flex bg-emerald-900 lg:px-2 py-2 md:py-4 lg:py-5 text-stone-200 select-none">
                <div className="container flex flex-wrap justify-between items-center mx-auto">
                    <Link to={"/"} className="flex items-center" onClick={() => closeMenu()}>
                        <img src="logo.svg" className="ml-2 lg:ml-0 md:mr-3 h-10 md:h-9 w-9" alt="Logo" />
                        <span
                            className="hidden md:flex whitespace-nowrap self-center text-2xl font-bold dark:text-white">Camellia Cultivar</span>
                    </Link>
                    {/* LINKS */}
                    <div className="fixed top-16 md:top-20 left-0 lg:top-0 lg:relative bg-white lg:mt-3 lg:bg-transparent w-full lg:flex lg:w-auto lg:order-0 order-1">
                        <ul className={navbarOpen ? openNavbar : closedNavbar}>
                            <li>
                                <NavLink to="/" end
                                    className={({ isActive }) => (
                                        isActive ? activeLink : link
                                    )}
                                    onClick={() => closeMenu()}
                                >
                                    Homepage
                                </NavLink>
                            </li>
                            <li>
                                <NavLink to="/quizzes"
                                    className={({ isActive }) => (
                                        isActive ? activeLink : link
                                    )}
                                    onClick={() => closeMenu()}
                                >
                                    Quizzes
                                </NavLink>
                            </li>
                            <li>
                                <NavLink to="/encyclopedia" end
                                    className={({ isActive }) => (
                                        isActive ? activeLink : link
                                    )}
                                    onClick={() => closeMenu()}
                                >
                                    Encyclopedia
                                </NavLink>
                            </li>
                            <li>
                                <NavLink to="/about"
                                    className={({ isActive }) => (
                                        isActive ? activeLink : link
                                    )}
                                    onClick={() => closeMenu()}
                                >
                                    About Us
                                </NavLink>
                            </li>
                        </ul>
                    </div>

                    <div className="lg:order-2 flex mr-1.5 lg:mr-0">
                        {/*LOGIN BUTTON*/}
                        {isLogged ? 
                        <div className="flex">
                            <button
                            onClick={() => { navigate("/profile"); closeMenu() }}
                            className="flex justify-center align-middle font-medium rounded-full md:rounded-md md:px-2 md:py-1 hover:bg-white/10 hover:ring-teal-400/50 hover:ring-2 m-auto mr-3 lg:mr-0 focus:outline-none"
                        >
                            <span className="px-1 self-center hidden md:flex">{`${user.first_name}`}</span>
                            <svg xmlns="http://www.w3.org/2000/svg" className="h-11 w-11 md:h-9 md:w-9" viewBox="0 0 20 20" fill="currentColor">
                                <path fillRule="evenodd" d="M18 10a8 8 0 11-16 0 8 8 0 0116 0zm-6-3a2 2 0 11-4 0 2 2 0 014 0zm-2 4a5 5 0 00-4.546 2.916A5.986 5.986 0 0010 16a5.986 5.986 0 004.546-2.084A5 5 0 0010 11z" clipRule="evenodd" />
                            </svg>
                        </button>
                        <button
                            onClick={() => { localStorage.removeItem("userToken");closeMenu(); window.location.push("/") }}
                            className="flex md:ml-4 justify-center font-medium rounded-full md:rounded-md md:px-2 md:py-1 hover:bg-white/10 hover:ring-teal-400/50 hover:ring-2 m-auto mr-3 lg:mr-0 focus:outline-none"
                        >
                            <span className="px-1 self-center hidden md:flex">Logout</span>
                        </button>
                        </div>
                            :
                            <button
                                onClick={() => { navigate("/login"); closeMenu() }}
                                className="flex justify-center align-middle font-medium rounded-full md:rounded-md md:px-2 md:py-1 hover:bg-white/10 hover:ring-teal-400/50 hover:ring-2 m-auto mr-3 lg:mr-0 focus:outline-none"
                            >
                                <span className="px-1 self-center hidden md:flex">Login</span>
                                <svg xmlns="http://www.w3.org/2000/svg" className="h-11 w-11 md:h-9 md:w-9" viewBox="0 0 20 20" fill="currentColor">
                                    <path fillRule="evenodd" d="M18 10a8 8 0 11-16 0 8 8 0 0116 0zm-6-3a2 2 0 11-4 0 2 2 0 014 0zm-2 4a5 5 0 00-4.546 2.916A5.986 5.986 0 0010 16a5.986 5.986 0 004.546-2.084A5 5 0 0010 11z" clipRule="evenodd" />
                                </svg>
                            </button>

                        }

                        {/* HAMBURGER TOGGLE */}
                        <div className="flex items-center lg:hidden">
                            <button className="p-2 rounded-md hover:bg-white/10 focus:outline-none hover:ring-teal-400/50 hover:ring-2 m-auto" onClick={() => handleToggle()}>
                                <svg xmlns="http://www.w3.org/2000/svg" className="h-8 w-8" fill="none" viewBox="0 0 24 24" stroke="currentColor" strokeWidth={2}>
                                    <path strokeLinecap="round" strokeLinejoin="round" d="M4 6h16M4 12h16M4 18h16" />
                                </svg>
                            </button>
                        </div>
                    </div>
                </div>
            </nav>
        </div>
    );
}
export default Navbar;