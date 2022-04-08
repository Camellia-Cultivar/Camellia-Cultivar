import React from 'react'

import './index.css'

const LoginCard = ({history}) => {

    const redirect = (route)=>{
       history.push(route)
    }

    return (
        <div className="container top-1/2 left-1/2 -translate-y-1/2 -translate-x-1/2 absolute min-h-max min-w-max max-w-2xl">
            <div className="bg-white flex flex-col justify-center align-middle border-2 border-b-3 rounded-lg pb-10 pt-8 shadow">
                <div className="mb-7">
                    <p className="font-bold text-center text-3xl">Login</p>
                </div>
                <div className="mx-auto flex flex-col my-2 min-w-lg">
                    <input className="mt-2 mb-4 mx-4 border-b-2 focus:outline-none focus:border-b-2 focus:border-b-emerald-600 focus:shadow" type="text" placeholder="Username"></input>
                    <input className="mx-4 my-2 border-b-2 focus:outline-none focus:border-b-2 focus:border-b-emerald-600 focus:shadow" type="text" placeholder="Password"></input>
                    <div className="mx-4 mt-1">
                        <input className="accent-emerald-900" type="checkbox" id="remember"></input> <label className="text-sm font-medium" for="remember">Remember Me</label>
                    </div>
                </div>
                <button className="bg-emerald-900 rounded-3xl w-3/4 self-center mt-6 mb-2 py-2 max-w-sm"><span className="text-lg text-white">LOGIN</span></button>
                <p onClick={()=>redirect("/register")} className="self-center mt-2 font-semibold text-sm underline underline-offset-1 hover:cursor-pointer">Don't have an account? Sign Up</p>
            </div>
        </div>
    )
}

export default LoginCard