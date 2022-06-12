import React, { useEffect, useState } from 'react'
import { useNavigate } from 'react-router-dom'
import { AiOutlineLoading3Quarters } from 'react-icons/ai'
import sha256 from 'crypto-js/sha256';
import Base64 from 'crypto-js/enc-base64'

import BallDecoration from '../../components/BallDecoration'


const Register = () => {
    const [nameError, setNameError] = useState(false);
    const [isLoading, setIsLoading] = useState(false);
    const [emailError, setEmailError] = useState(false);
    const [passwordError, setPasswordError] = useState(false);


    const navigate = useNavigate();


    useEffect(() => {
        const onEnterPress = event => {
            if (event.key === 'Enter') {
                event.preventDefault();
                submitUser();
            }
        }
        document.addEventListener('keydown', onEnterPress);

        return () => {
            document.removeEventListener('keydown', onEnterPress);
        }
    }, []);


    const submitUser = () => {
        setEmailError(false);
        setPasswordError(false);
        setEmailError(false);

        if (document.getElementById("register-fn").value.length === 0 || document.getElementById("register-ln").value.length === 0) {
            setNameError(true);
            return;
        }


        if (!(document.getElementById("register-email").value.split("@")[0].length > 1 && document.getElementById("register-email").value.split("@")[1].length > 1
            && document.getElementById("register-email").value.split("@")[1].includes("."))) {
            setEmailError(true);
            return;
        }
        if (document.getElementById("register-password").value !== document.getElementById("register-confirm-password").value) {
            setPasswordError(true);
            return;
        }

        setIsLoading(true);



        const user = {
            first_name: document.getElementById("register-fn").value,
            last_name: document.getElementById("register-ln").value,
            email: document.getElementById("register-email").value,
            password: Base64.stringify((sha256(document.getElementById("register-password").value))),
        }

        const axios = require('axios').default;

        axios.post('/api/users/signup', user, {
            headers: {
                'content-type': 'application/json'
            }
        })
            .then(function () {
                navigate('/login');
        setIsLoading(false);

            })
            .catch(function (_error) {
                return;
            });

    }

    return (
        <div className="container-4/5 my-10">
            <div className="xl:absolute xl:top-1/2 xl:left-1/2 xl:-translate-x-1/2 xl:-translate-y-1/2">
                <div className="mb-7">
                    <p className="text-3xl font-bold text-center">Create Account</p>
                </div>
                <div className="flex flex-col">
                    <div className="contents md:flex md:justify-between mt-4 md:mt-2">
                        <div className="flex flex-col md:mr-2 mt-3 md:my-0 w-full">
                            <label className="ml-2 font-semibold text-sm mb-0.5 md:text-base " htmlFor='register-fn'>First Name</label>
                            <input className="bg-stone-100 rounded-xl border-2 px-2 py-1" type="text" id="register-fn" required></input>

                        </div>
                        <div className="flex flex-col md:ml-2 mt-3 md:my-0 w-full">
                            <label className="ml-2 font-semibold text-sm mb-0.5 md:text-base " htmlFor='register-ln'>Last Name</label>
                            <input className="bg-stone-100 rounded-xl border-2 px-2 py-1" type="text" id="register-ln" required></input>

                        </div>
                    </div>
                    {nameError && <p className="ml-3 mt-1 text-xs text-red-800">* Please enter a valid name</p>}
                    <label className="mt-3 md:mt-2 ml-2 font-semibold text-sm mb-0.5 md:text-base " htmlFor='register-email'>Email</label>
                    <input className="bg-stone-100 rounded-xl border-2 px-2 py-1" type="email" id="register-email" required></input>
                    {emailError && <p className="ml-3 mt-1 text-xs text-red-800">* Please enter a valid email</p>}
                    <label className="mt-3 md:mt-2 ml-2 font-semibold text-sm mb-0.5 md:text-base " htmlFor='register-password'>Password</label>
                    <input className="bg-stone-100 rounded-xl border-2 px-2 py-1" type="password" id="register-password" required></input>
                    <label className="mt-3 md:mt-2 ml-2 font-semibold text-sm mb-0.5 md:text-base " htmlFor='register-confirm-password'>Repeat Password</label>
                    <input className="bg-stone-100 rounded-xl border-2 px-2 py-1" type="password" id="register-confirm-password" required></input>
                    {passwordError && <p className="ml-3 mt-1 text-xs text-red-800">* Passwords must match</p>}
                    <button type="submit" onClick={() => submitUser()} className="bg-emerald-900 flex justify-center rounded-3xl w-3/4 self-center mt-6 mb-2 py-2 max-w-sm active:scale-95">
                        {isLoading ?
                            <AiOutlineLoading3Quarters className="text-lg loading text-white"></AiOutlineLoading3Quarters>
                            :
                            <span className="text-lg text-white">GET STARTED</span>}
                    </button>
                </div>
            </div>
            <BallDecoration className="hidden xl:contents "></BallDecoration>

        </div>
    )
}

export default Register