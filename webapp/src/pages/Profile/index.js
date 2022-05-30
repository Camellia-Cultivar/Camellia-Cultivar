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

    }, []);

    return (
        <div className='mt-16 container-4/5'>
            <p className="text-4xl font-bold text-emerald-900">Welcome {user.first_name}!</p>
            <div className="flex mt-16">
                {isEditing ? <ProfileEditCard person={user} setPerson={(p) => { setPerson(p) }} setIsEditing={(editing) => { setIsEditing(editing) }}></ProfileEditCard> : <ProfileCard person={user} setIsEditing={(editing) => { setIsEditing(editing) }}></ProfileCard>}
                <div className="ml-24">
                    <p className="text-2xl font-bold text-emerald-900">Your Requests</p>
                    {
                        requests.map((request, index) => {
                            return (
                                <div key={index} className="grid grid-cols-8 my-4 gap-2 border-2 rounded-lg border-emerald-900/10 bg-emerald-900/5 pr-4">
                                    <img alt="" src={request.image} className=" h-[100px] w-[100px] object-scale-down rounded-tl-lg rounded-bl-lg"></img>
                                    <div className="flex flex-col justify-around ml-4 col-span-2 font-medium">
                                        <div className="flex items-center ">
                                            <IoCalendarNumberOutline></IoCalendarNumberOutline>
                                            <p className="ml-2">{request.date}</p>
                                        </div>
                                        <div className="flex items-center">
                                            <IoLocationOutline></IoLocationOutline>
                                            <p className="ml-2">{request.location}</p>
                                        </div>
                                    </div>
                                    <div className="ml-4 flex items-center col-span-2">
                                        <p className="text-lg font-medium mx-2">Status: </p>
                                        <p className="mx-2">{request.status}</p>
                                    </div>
                                    <div className="ml-4 col-span-3">
                                        {request.identifications.length === 0 ? <div className="flex items-center justify-center h-full"><p className="text-lg font-medium text-center ">No Results</p></div> : <p className="text-lg font-medium mt-2">Results: </p>}
                                        <div className="flex flex-col justify-center">
                                            {request.identifications.map((result, ind) => {
                                                return (
                                                    <p key={ind}>
                                                        {result.name} : {result.percentage}%
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
    )
}

export default Profile