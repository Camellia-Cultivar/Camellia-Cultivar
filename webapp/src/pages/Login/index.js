import React from 'react'
import {useNavigate} from 'react-router-dom';

import LoginCard from '../../components/LoginCard'

import './index.css'

const Login = () => {

    const navigate = useNavigate();
    return (
        <div id="login" className="">
            <div className="md:bg-emerald-900 fixed w-full h-1/2 top-0 -z-10"></div>
            <LoginCard navigate={navigate}></LoginCard>
        </div>
    )
}

export default Login