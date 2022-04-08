import React from 'react'

import LoginCard from '../../components/LoginCard'

import './index.css'

const Login = ({history}) => {


    return (
        <div className="">
            <div className="bg-emerald-900 absolute w-full h-1/2 top-0 -z-10"></div>
            <LoginCard history={history}></LoginCard>
        </div>
    )
}

export default Login