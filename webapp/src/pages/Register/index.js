import React from 'react'
import BallDecoration from '../../components/BallDecoration'

const Register = () => {
    return (
        <div className="">
            <div className="absolute top-1/2 left-1/2 -translate-x-1/2 -translate-y-1/2">
                <div className="mb-8">
                    <p className="text-3xl font-bold text-center">Create Account</p>
                </div>
                <div className="flex flex-col">
                    <div className="flex justify-between my-2">
                        <input className="bg-stone-100 rounded-xl border-2 px-2 py-1 mr-2" type="text" placeholder="First Name"></input>
                        <input className="bg-stone-100 rounded-xl border-2 px-2 py-1 ml-2" type="text" placeholder="Last Name"></input>
                    </div>
                    <input className="bg-stone-100 rounded-xl border-2 px-2 py-1 my-2" type="text" placeholder="Username"></input>
                    <input className="bg-stone-100 rounded-xl border-2 px-2 py-1 my-2" type="email" placeholder="Email"></input>
                    <input className="bg-stone-100 rounded-xl border-2 px-2 py-1 my-2" type="password" placeholder="Password"></input>
                    <input className="bg-stone-100 rounded-xl border-2 px-2 py-1 my-2" type="password" placeholder="Confirm Password"></input>
                    <button className="bg-emerald-900 rounded-3xl w-3/4 self-center mt-6 mb-2 py-2 max-w-sm"><span className="text-lg text-white">GET STARTED</span></button>
                </div>
            </div>
            <BallDecoration></BallDecoration>

        </div>
    )
}

export default Register