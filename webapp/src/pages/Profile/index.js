import React, { useState, useEffect } from 'react'
import { useNavigate } from 'react-router-dom'
import { IoCalendarNumberOutline, IoLocationOutline } from 'react-icons/io5'
import { useDispatch, useSelector } from 'react-redux'

import { signOut } from '../../redux/actions'

import ProfileCard from '../../components/ProfileCard'
import ProfileEditCard from '../../components/ProfileEditCard'

import axios from 'axios'

const Profile = () => {
    const [isEditing, setIsEditing] = useState(false);
    const [fetched, setFetched] = useState(false);
    const [requests, setRequests] = useState([])

    const dispatch = useDispatch();
    const navigate = useNavigate();

    const user = useSelector(state => state.user);


    useEffect(() => {
        const loggedInUser = localStorage.getItem("userToken");
        if (loggedInUser) {
            const tempUser = JSON.parse(loggedInUser);
            if (tempUser.expiry < Date.now()) {
                localStorage.removeItem("userToken");
                dispatch(signOut());
                navigate("/");
            } else {
                const options = {
                    headers: {
                        'Authorization': 'Bearer ' + JSON.parse(loggedInUser).loginToken
                    }
                }
                !fetched && axios.get('/api/requests/identification', options)
                    .then(response => {
                        setRequests(response.data);
                        setFetched(true);
                    })
            }
        }

    });

    return (
        <div className='mt-16 container-4/5'>
            <p className=" text-xl md:text-2xl lg:text-4xl font-bold text-emerald-900 fade-in" style={{ animationDelay: `100ms` }}>Welcome {user.first_name}!</p>
            <div className="flex flex-col lg:flex-row mt-8 md:mt-10">
                {isEditing ? <ProfileEditCard person={user} setIsEditing={(editing) => { setIsEditing(editing) }}></ProfileEditCard> : <ProfileCard person={user} setIsEditing={(editing) => { setIsEditing(editing) }}></ProfileCard>}
                {requests.length === 0 ?
                    <div className="mt-16 lg:mt-0 lg:ml-16 xl:mx-auto xl:px-4 fade-in" style={{ animationDelay: `300ms` }}>
                        <p className="text-xl lg:text-3xl font-bold">You have no <span className="font-extrabold text-emerald-900">requests!</span></p>
                    </div>
                    :
                    <div className="mt-16 lg:mt-0 lg:ml-16 xl:mx-auto xl:px-4">
                        <p className="text-xl lg:text-2xl font-bold text-emerald-900">Your Requests</p>
                        <div className="my-4 grid gap-8 xl:grid-cols-2">
                            {
                                requests.map((request, index) => {
                                    return (
                                        <div key={index} className=" grid grid-flow-row md:grid-cols-8 lg:grid-cols-none gap-2 border-2 rounded-lg border-emerald-900/10 bg-emerald-900/5 p-4">
                                            <img alt="" src={request.photo} className=" h-[100px] w-[100px] object-scale-down mx-auto rounded-lg"></img>
                                            <div className="flex flex-col justify-around  md:col-span-2 font-medium mt-4">
                                                <div className="flex items-center ">
                                                    <IoCalendarNumberOutline></IoCalendarNumberOutline>
                                                    <p className="ml-2">{request.submission.split('T')[0]}</p>
                                                </div>
                                                <div className="flex items-center mt-1 md:mt-0">
                                                    <IoLocationOutline></IoLocationOutline>
                                                    <p className="ml-2">{request.address}</p>
                                                </div>
                                            </div>
                                            <div className=" md:ml-4 mt-2 md:col-span-3">
                                                {Object.keys(request.cultivarProbabilities).length === 0 ?
                                                    <div className="flex items-center justify-center h-full"><p className="md:text-lg font-medium text-center ">No Results</p></div>
                                                    :
                                                    <p className="md:text-lg font-medium">Results: </p>}
                                                <div className="flex flex-col justify-center">
                                                    {Object.keys(request.cultivarProbabilities).map((key, ind) => {
                                                        return (
                                                            <p className="text-sm mt-2" key={`user-identification-prob-${ind}`}>
                                                                {key} :  {request.probabilities[key]}%
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

                    </div>}
            </div>

        </div>
    )
}

export default Profile