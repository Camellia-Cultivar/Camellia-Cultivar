import React, { useState, useEffect } from 'react';
import { AiOutlineLoading3Quarters } from 'react-icons/ai'
import axios from 'axios';
import sha256 from 'crypto-js/sha256';
import Base64 from 'crypto-js/enc-base64';

import { tokenTtl } from '../../utilities/ttl';

const LoginCard = (props) => {
    const [isLoading, setIsLoading] = useState(false);
    const [wrongCredentials, setWrongCredentials] = useState(false);
    const [userNotAuthenticated, setUserNotAuthenticated] = useState(false);

    // Enter listener
    useEffect(() => {
        const onEnterPress = event => {
            if (event.key === 'Enter') {
                event.preventDefault();
                loginUser();
            }
        }
        document.addEventListener('keydown', onEnterPress);
        return () => {
            document.removeEventListener('keydown', onEnterPress);
        }
    });

    const loginUser = () => {
        const email = document.getElementById('login-email').value;
        const password = document.getElementById('login-password').value;
        setIsLoading(true);
        axios.post('/api/users/login', { email: email, password: Base64.stringify((sha256(password))) })
            .then(function (response) {
                if ((response.status === 200) && window.localStorage) {
                    if (response.data === '') {
                        setWrongCredentials(true);
                        setIsLoading(false);
                    } else {
                        const token = { userId: response.data.split(' ')[0], loginToken: response.data.split(' ')[1], expiry: Date.now() + tokenTtl }
                        const options = {
                            headers: { 'Authorization': `Bearer ${token.loginToken}` }
                        }
                        axios.get(`/api/users/${token.userId}`, options)
                            .then(() => {
                                localStorage.setItem("userToken", JSON.stringify(token));
                                setWrongCredentials(false);
                                setIsLoading(false);
                                props.navigate("/")
                            })
                            .catch(err => {
                                if (err.message === 'Request failed with status code 401') {
                                    setWrongCredentials(false);
                                    setUserNotAuthenticated(true);
                                    setIsLoading(false);
                                }
                            })
                    }
                }
            })
            .catch(function (_error) {
                return;
            });

    }

    return (
        <div className="container mt-10 md:mt-0 mx-auto md:top-1/2 md:left-1/2 md:-translate-y-1/2 md:-translate-x-1/2 md:absolute min-h-max min-w-max max-w-2xl">
            <div className="bg-white flex flex-col md:border-2 md:border-b-[3px] md:rounded-lg pb-10 pt-8 md:shadow">
                <div className="mb-7">
                    <p className="font-bold text-center text-3xl">Login</p>
                </div>
                <div className="lg:mx-auto flex flex-col my-2 lg:min-w-[30rem]">
                    <div className='relative mt-5 md:mt-2 mb-8 md:mb-4 mx-4'>
                        <input

                            id="login-email"
                            className="border-b-2 focus:outline-none focus:border-b-2 focus:border-b-emerald-600 w-full peer "
                            type="email"
                            placeholder=" "></input>
                        <label
                            className="absolute left-0 cursor-text text-black/50 transform -translate-y-5 -translate-x-1 peer-focus:scale-90 scale-90 peer-focus:text-emerald-900 peer-focus:font-semibold duration-300 peer-placeholder-shown:scale-100"
                            htmlFor="login-email">Email</label>
                    </div>
                    <div className='relative mt-5 mb-8 md:mb-4 mx-4'>
                        <input
                            id="login-password"
                            className=" border-b-2 focus:outline-none focus:border-b-2 focus:border-b-emerald-600 w-full peer"
                            type="password"
                            placeholder=" "></input>
                        <label
                            className="absolute left-0 cursor-text text-black/50 transform peer-focus:-translate-y-5 peer-focus:-translate-x-1 -translate-y-5 -translate-x-1 peer-focus:scale-90 peer-focus:text-emerald-900 scale-90 peer-focus:font-semibold peer-placeholder-shown:scale-100 duration-300" htmlFor="login-password">Password</label>
                    </div>
                    {wrongCredentials &&
                        <span className="text-red-700 text-sm font-medium text-center mx-4 mt-4 md:mt-1" type="checkbox" id="wrongCredentials">Your email or password are wrong, please try again!</span>
                    }
                    {userNotAuthenticated &&
                        <span className="text-red-700 text-sm font-medium text-center mx-4 mt-4 md:mt-1" type="checkbox" id="wrongCredentials">Please verify your account and then login again!</span>
                    }
                </div>
                <button type="submit" onClick={() => loginUser()} className="flex justify-center bg-emerald-900 rounded-3xl w-3/4 self-center mt-10 md:mt-6 mb-4 md:mb-2 py-2 max-w-sm active:scale-95">{isLoading ? <AiOutlineLoading3Quarters className="text-white text-lg loading"></AiOutlineLoading3Quarters> : <span className="text-lg text-white">LOGIN</span>}</button>
                <p onClick={() => props.navigate("/register")} className="self-center mt-4 md:mt-2 hover:font-semibold text-base md:text-sm underline underline-offset-1 cursor-pointer">Don't have an account? Sign Up</p>
            </div>
        </div>
    )
}

export default LoginCard