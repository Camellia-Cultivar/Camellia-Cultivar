import React from 'react';
import {Link, NavLink, useNavigate} from 'react-router-dom';
import {IoEnterOutline} from 'react-icons/io5';

const Navbar = () =>{

    let activeClassName = "block text-base mx-3 py-0.5 border-b-2 border-teal-400";
    let inactiveClassName="block text-base mx-3 py-0.5 border-b-2 border-transparent hover:border-white hover:text-white";

    let navigate = useNavigate();

    return (
        <nav className="flex bg-emerald-900 px-2 sm:px-4 py-6 text-stone-200 select-none">
            <div className="container flex flex-wrap justify-between items-center mx-auto">
                <Link to={"/"} className="flex items-center">
                    <img src="logo192.png" className="mr-3 h-6 sm:h-9" alt="Logo"/>
                    <span
                        className="self-center text-2xl font-bold whitespace-nowrap dark:text-white">Camellia Cultivar</span>
                </Link>
                <div className="flex items-center md:order-2 ">
                    <button
                            className="flex mr-3 text-sm bg-gray-800 rounded-full md:mr-0 focus:ring-4 focus:ring-gray-300 dark:focus:ring-gray-600"
                            id="user-menu-button" aria-expanded="false" type="button" data-dropdown-toggle="dropdown">
                        <span className="sr-only">Open user menu</span>
                        {/*<img className="w-8 h-8 rounded-full" src="/docs/images/people/profile-picture-3.jpg" alt="user photo" />*/}
                    </button>
                    <div
                        className="hidden z-50 my-4 text-base list-none bg-white rounded divide-y divide-gray-100 shadow dark:bg-gray-700 dark:divide-gray-600"
                        id="dropdown">
                        <div className="py-3 px-4">
                            <span className="block text-sm text-gray-900 dark:text-white">Bonnie Green</span>
                            <span
                                className="block text-sm font-medium text-gray-500 truncate dark:text-gray-400">name@flowbite.com</span>
                        </div>
                    </div>
                    <button data-collapse-toggle="mobile-menu-2" type="button"
                            className="inline-flex items-center p-2 ml-1 text-sm text-gray-500 rounded-lg md:hidden hover:bg-gray-100 focus:outline-none focus:ring-2 focus:ring-gray-200 dark:text-gray-400 dark:hover:bg-gray-700 dark:focus:ring-gray-600"
                            aria-controls="mobile-menu-2" aria-expanded="false">
                        <span className="sr-only">Open main menu</span>
                    </button>
                </div>
                <div className="justify-between items-center w-full md:flex md:w-auto md:order-1">
                    <ul className="flex flex-col mt-4 text-base md:flex-row md:space-x-8 md:mt-0 md:text-sm md:font-medium">
                        <li>
                            <NavLink to="/" end
                                     className={({ isActive }) => (
                                         isActive ? activeClassName : inactiveClassName
                                     )}
                            >
                                Homepage
                            </NavLink>
                        </li>
                        <li>
                            <NavLink to="/encyclopedia" end
                                     className={({ isActive }) => (
                                         isActive ? activeClassName : inactiveClassName
                                     )}
                            >
                                Encyclopedia
                            </NavLink>
                        </li>
                        <li>
                            <NavLink to="/about"
                                className={({ isActive }) => (
                                    isActive ? activeClassName : inactiveClassName
                                )}
                            >
                                About Us
                            </NavLink>
                        </li>
                    </ul>
                </div>
            </div>
            <button onClick={()=>{navigate("/login")}} className="flex justify-self-end mr-4 font-medium border-2 rounded-md border-emerald-900 px-4 hover:border-white hover:text-white"><span className="self-center mr-1">Login</span><IoEnterOutline  className="self-center mt-1"/></button>
            
        </nav>
    );
}
export default Navbar;