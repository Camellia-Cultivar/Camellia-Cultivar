import React, { useState, useEffect } from 'react'
import { useNavigate } from 'react-router-dom'
import { IoCalendarNumberOutline, IoLocationOutline } from 'react-icons/io5'
import { useDispatch, useSelector } from 'react-redux'

import { signOut } from '../../redux/actions'

import ProfileCard from '../../components/ProfileCard'
import ProfileEditCard from '../../components/ProfileEditCard'

import details from "./details"
import requests from "./requests"

const Profile = () => {
    const [isEditing, setIsEditing] = useState(false);
    const [person, setPerson] = useState(details);

    const dispatch = useDispatch();
    const navigate = useNavigate();

    const user = useSelector(state => state.user)


    useEffect(() => {
        const loggedInUser = localStorage.getItem("userToken");
        if (loggedInUser) {
            const tempUser = JSON.parse(loggedInUser);
            if (tempUser.expiry < Date.now()) {
                localStorage.removeItem("userToken");
                dispatch(signOut());
                navigate("/");
            }
        }

    });

    return (
        <div className='mt-16 container-4/5'>
            <p className=" text-xl md:text-2xl lg:text-4xl font-bold text-emerald-900">Welcome {user.first_name}!</p>
            <div className="flex flex-col lg:flex-row mt-8 md:mt-10">
                {isEditing ? <ProfileEditCard person={user} setPerson={(p) => { setPerson(p) }} setIsEditing={(editing) => { setIsEditing(editing) }}></ProfileEditCard> : <ProfileCard person={user} setIsEditing={(editing) => { setIsEditing(editing) }}></ProfileCard>}
                <div className="mt-16 lg:mt-0 lg:ml-16 xl:mx-auto xl:px-4">
                    <p className="text-xl lg:text-2xl font-bold text-emerald-900">Your Requests</p>
                    <div className="my-4 grid gap-8 xl:grid-cols-2">
                        {
                            requests.map((request, index) => {
                                return (
                                    <div key={index} className=" grid grid-flow-row md:grid-cols-8 lg:grid-cols-none gap-2 border-2 rounded-lg border-emerald-900/10 bg-emerald-900/5 p-4">
                                        <img alt="" src={request.image} className=" h-[100px] w-[100px] object-scale-down mx-auto rounded-lg"></img>
                                        <div className="flex flex-col justify-around  md:col-span-2 font-medium mt-4">
                                            <div className="flex items-center ">
                                                <IoCalendarNumberOutline></IoCalendarNumberOutline>
                                                <p className="ml-2">{request.date}</p>
                                            </div>
                                            <div className="flex items-center mt-1 md:mt-0">
                                                <IoLocationOutline></IoLocationOutline>
                                                <p className="ml-2">{request.location}</p>
                                            </div>
                                        </div>
                                        <div className=" flex items-center mt-2 md:mt-0 md:col-span-2">
                                            <p className="md:text-lg font-medium md:mx-2">Status: </p>
                                            <p className="mx-2 text-sm md:text-base">{request.status}</p>
                                        </div>
                                        <div className=" md:ml-4 mt-2 md:col-span-3">
                                            {request.identifications.length === 0 ?
                                                <div className="flex items-center justify-center h-full"><p className="md:text-lg font-medium text-center ">No Results</p></div>
                                                :
                                                <p className="md:text-lg font-medium">Results: </p>}
                                            <div className="flex flex-col justify-center">
                                                {request.identifications.map((result, ind) => {
                                                    return (
                                                        <p className="text-sm mt-2" key={ind}>
                                                            {result.name} :  {result.percentage}%
                                                        </p>
                                                    )
                                                })}

                                            </div>
                                        </div>
                                    </div>
                                )
                            })
                        }
                    </div>

                </div>
            </div>

        </div>
    )
}

export default Profile