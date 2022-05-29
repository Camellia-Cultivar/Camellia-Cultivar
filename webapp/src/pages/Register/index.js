import React from 'react'
import { useNavigate } from 'react-router-dom'
import BallDecoration from '../../components/BallDecoration'


const Register = () => {

    const navigate = useNavigate();

    const submitUser = () => {

        const user = {
            first_name: document.getElementById("fn").value,
            last_name: document.getElementById("ln").value,
            email: document.getElementById("email").value,
            password: document.getElementById("password").value,
        }

        const axios = require('axios').default;

        axios.post('/api/users/signup', user)
            .then(function (response) {
                console.log(response);
                navigate('/login');

            })
            .catch(function (error) {
                console.log(error);
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
                            <label className="ml-2 font-semibold text-sm mb-0.5 md:text-base " htmlFor='fn'>First Name</label>
                            <input className="bg-stone-100 rounded-xl border-2 px-2 py-1" type="text" id="fn"></input>

                        </div>
                        <div className="flex flex-col md:ml-2 mt-3 md:my-0 w-full">
                            <label className="ml-2 font-semibold text-sm mb-0.5 md:text-base " htmlFor='ln'>Last Name</label>
                            <input className="bg-stone-100 rounded-xl border-2 px-2 py-1" type="text" id="ln"></input>
                        </div>
                    </div>
                    <label className="mt-3 md:mt-2 ml-2 font-semibold text-sm mb-0.5 md:text-base " htmlFor='email'>Email</label>
                    <input className="bg-stone-100 rounded-xl border-2 px-2 py-1" type="email" id="email"></input>
                    <label className="mt-3 md:mt-2 ml-2 font-semibold text-sm mb-0.5 md:text-base " htmlFor='password'>Password</label>
                    <input className="bg-stone-100 rounded-xl border-2 px-2 py-1" type="password" id="password"></input>
                    <label className="mt-3 md:mt-2 ml-2 font-semibold text-sm mb-0.5 md:text-base " htmlFor='confirm-password'>Repeat Password</label>
                    <input className="bg-stone-100 rounded-xl border-2 px-2 py-1" type="password" id="confirm-password"></input>
                    <button onClick={() => submitUser()} className="bg-emerald-900 rounded-3xl w-3/4 self-center mt-6 mb-2 py-2 max-w-sm active:scale-95"><span className="text-lg text-white">GET STARTED</span></button>
                </div>
            </div>
            <BallDecoration className="hidden xl:contents "></BallDecoration>

        </div>
    )
}

export default Register