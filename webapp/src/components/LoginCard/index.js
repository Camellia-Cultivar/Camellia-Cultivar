import React from 'react'

import { tokenTtl } from '../../utilities/ttl';

const LoginCard = (props) => {

    const redirect = (route) => {
        props.navigate(route);
    }

    const loginUser = () => {
        const email = document.getElementById('email').value;
        const password = document.getElementById('password').value;
        console.log({ "email": email, "password": password })
        const axios = require('axios').default;
        axios.post('https://localhost:8085/api/users/login', { email: email, password: password })
            .then(function (response) {
                console.log(response);
                if((response.status === 200 || response.status === 201) && window.localStorage){
                    const token ={userId:response.data.split(' ')[0],loginToken:response.data.split(' ')[1], expiry:Date.now()+tokenTtl}
                    localStorage.setItem("userToken", JSON.stringify(token));
                    props.navigate("/")
                }
            })
            .catch(function (error) {
                console.log(error);
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
                        <input id="email" className="border-b-2 focus:outline-none focus:border-b-2 focus:border-b-emerald-600 w-full peer " type="text" placeholder=""></input>
                        <label className="absolute left-0 cursor-text text-black/50 transform peer-focus:-translate-y-5 -translate-y-5 -translate-x-1 peer-focus:-translate-x-1 peer-focus:scale-90 scale-90 peer-focus:text-emerald-900 peer-focus:font-semibold duration-300 peer-placeholder-shown:" htmlFor="username">Username</label>
                    </div>
                    <div className='relative mt-5 mb-8 md:mb-4 mx-4'>
                        <input id="password" className=" border-b-2 focus:outline-none focus:border-b-2 focus:border-b-emerald-600 w-full peer" type="text" placeholder=""></input>
                        <label className="absolute left-0 cursor-text text-black/50 transform peer-focus:-translate-y-5 peer-focus:-translate-x-1 -translate-y-5 -translate-x-1 peer-focus:scale-90 peer-focus:text-emerald-900 peer-focus:font-semibold duration-300" htmlFor="password">Password</label>
                    </div>
                    {/* <div className="mx-4 mt-4 md:mt-1">
                        <input className="accent-emerald-900" type="checkbox" id="remember"></input> <label className="text-sm font-medium" htmlFor="remember">Remember Me</label>
                    </div> */}
                </div>
                <button onClick={() => loginUser()} className="bg-emerald-900 rounded-3xl w-3/4 self-center mt-10 md:mt-6 mb-4 md:mb-2 py-2 max-w-sm active:scale-95"><span className="text-lg text-white">LOGIN</span></button>
                <p onClick={() => redirect("/register")} className="self-center mt-4 md:mt-2 hover:font-semibold text-base md:text-sm underline underline-offset-1 cursor-pointer">Don't have an account? Sign Up</p>
            </div>
        </div>
    )
}

export default LoginCard