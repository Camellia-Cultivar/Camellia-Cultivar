import React from 'react'


const LoginCard = ({navigate}) => {

    const redirect = (route)=>{
       navigate(route);
    }

    return (
        <div className="container mt-10 md:mt-0 mx-auto md:top-1/2 md:left-1/2 md:-translate-y-1/2 md:-translate-x-1/2 md:absolute min-h-max min-w-max max-w-2xl">
            <div className="bg-white flex flex-col md:border-2 md:border-b-[3px] md:rounded-lg pb-10 pt-8 md:shadow">
                <div className="mb-7">
                    <p className="font-bold text-center text-3xl">Login</p>
                </div>
                <div className="lg:mx-auto flex flex-col my-2 lg:min-w-[30rem]">
                    <input className="mt-5 md:mt-2 mb-8 md:mb-4 mx-4 border-b-2 focus:outline-none focus:border-b-2 focus:border-b-emerald-600 focus:shadow" type="text" placeholder="Username"></input>
                    <input className="mx-4 my-6 md:my-2 border-b-2 focus:outline-none focus:border-b-2 focus:border-b-emerald-600 focus:shadow" type="text" placeholder="Password"></input>
                    <div className="mx-4 mt-4 md:mt-1">
                        <input className="accent-emerald-900" type="checkbox" id="remember"></input> <label className="text-sm font-medium" for="remember">Remember Me</label>
                    </div>
                </div>
                <button className="bg-emerald-900 rounded-3xl w-3/4 self-center mt-10 md:mt-6 mb-4 md:mb-2 py-2 max-w-sm"><span className="text-lg text-white">LOGIN</span></button>
                <p onClick={()=>redirect("/register")} className="self-center mt-4 md:mt-2 font-semibold text-base md:text-sm underline underline-offset-1 hover:cursor-pointer">Don't have an account? Sign Up</p>
            </div>
        </div>
    )
}

export default LoginCard