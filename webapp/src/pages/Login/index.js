import React from 'react'
import {useNavigate} from 'react-router-dom';

import LoginCard from '../../components/LoginCard'

import './index.css'

const Login = () => {

    const navigate = useNavigate();
    return (
        <div className="">
            <div className="bg-emerald-900 absolute w-full h-1/2 top-0 -z-10"></div>
            <LoginCard navigate={navigate}></LoginCard>
        </div>
    )
}

export default Login