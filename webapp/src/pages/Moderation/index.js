import React, { useState, useEffect } from 'react'
import { IoClose, IoCheckmark, IoPersonOutline, IoAtOutline, IoStarOutline } from 'react-icons/io5';
import { AiOutlineLoading3Quarters } from 'react-icons/ai'
import axios from 'axios'

import CharacteristicDropdown from '../../components/CharacteristicDropdown/index.js';
import Map from '../../components/ModerationMap/index.js';

import ProfileDetails from '../../components/ProfileDetails/index.js';
import { proxy } from '../../utilities/proxy.js';


const Moderation = () => {
    const mode = "Approve Requests";
    const [currentPhoto, setCurrentPhoto] = useState(0);
    const [modalOn, setModalOn] = useState(false);
    const [submitter, setSubmitter] = useState({});
    const [specimen, setSpecimen] = useState({});
    const [request, setRequest] = useState({});
    const [person, setPerson] = useState({});
    const [photos, setPhotos] = useState([])
    const [fetched, setFetched] = useState(false);
    const [characteristics, setCharacteristics] = useState([]);
    const [isLoading, setIsLoading] = useState(false);
    const [noRequests, setNoRequests] = useState(false);



    const profileImage = person.profile_image === "null" || person.profile_image === undefined ?
        <svg xmlns="http://www.w3.org/2000/svg" className="h-[150px] w-[150px] md:h-[300px] md:w-[300px] self-center" viewBox="0 0 20 20" fill="currentColor">
            <path fillRule="evenodd" d="M18 10a8 8 0 11-16 0 8 8 0 0116 0zm-6-3a2 2 0 11-4 0 2 2 0 014 0zm-2 4a5 5 0 00-4.546 2.916A5.986 5.986 0 0010 16a5.986 5.986 0 004.546-2.084A5 5 0 0010 11z" clipRule="evenodd" />
        </svg>
        :
        <img alt="" className=" rounded-full aspect-square object-cover h-[150px] w-[150px] md:h-[300px] md:w-[300px] border-4 border-emerald-900 self-center" src={person.profile_image} />

    useEffect(() => {
        let userToken = localStorage.getItem("userToken");
        if (userToken) {
            const user = JSON.parse(userToken);
            const options = {
                headers: {
                    'Authorization': 'Bearer ' + user.loginToken
                }
            }
            !fetched && axios.get(`${proxy}/api/moderator/identification`, options)
                .then(response => {
                    if (response.data === "") {
                        setNoRequests(true);
                        return;
                    }
                    setRequest(response.data);
                    setSubmitter(response.data.submitter);
                    setSpecimen(response.data.toIdentifySpecimen);
                    setPhotos(response.data.toIdentifySpecimen.photos);
                    setCharacteristics(response.data.toIdentifySpecimen.characteristicValues);
                    setFetched(true);
                })
        }
    });


    const acceptRequest = () => {
        let userToken = localStorage.getItem("userToken");
        if (userToken) {
            const user = JSON.parse(userToken);
            const options = {
                headers: {
                    'Authorization': 'Bearer ' + user.loginToken
                }
            }

            axios.put(`${proxy}/api/moderator/identification/${request.requestId}/approve`, {}, options)
                .then(response => {
                    if (response.status === 202) {
                        setIsLoading(true);
                        setFetched(false);
                        setTimeout(() => setIsLoading(false), 500);
                    }
                })
        }
    }

    const getUserProfile = () => {
        const userToken = localStorage.getItem("userToken");
        if (userToken) {
            const user = JSON.parse(userToken);
            const options = {
                headers: {
                    'Authorization': 'Bearer ' + user.loginToken
                }
            }
            axios.get(`${proxy}/api/users/${submitter.userId}`, options)

                .then(response => {
                    setPerson(response.data);
                    setModalOn(true);
                })
                .catch(_err => {
                    return;
                })
        }
    }

    const setAutoApproval = () => {
        const userToken = localStorage.getItem("userToken");
        if (userToken) {
            const user = JSON.parse(userToken);
            const options = {
                headers: {
                    'Authorization': 'Bearer ' + user.loginToken
                }
            }
            axios.put(`${proxy}/api/users/autoapproval/${submitter.userId}`, {}, options)
                .then(_response => {
                    getUserProfile();
                })
                .catch(_err => {
                    return;
                })
        }
    }

    const deleteRequest = () => {
        const userToken = localStorage.getItem("userToken");
        if (userToken) {
            const user = JSON.parse(userToken);
            const options = {
                headers: {
                    'Authorization': 'Bearer ' + user.loginToken
                },
                params: {
                    specimen:specimen.specimenId
                }
            }
            axios.delete(`${proxy}/api/moderator/specimen/${request.requestId}`, options)
                .then(() => {
                    setIsLoading(true);
                    setFetched(false);
                    setTimeout(() => setIsLoading(false), 500);
                })
                .catch(_err => {
                    return;
                })
        }
    }

    const changeAmplified = (index) => {
        document.getElementById(`moderation-camellia-image-${currentPhoto}`).classList.remove("current");
        setCurrentPhoto(index);
        document.getElementById(`moderation-camellia-image-${index}`).classList.add("current");
    }

    return (
        <div className="mt-10 md:mt-16 container-4/5 mb-8">
            <div>
                <p className=" text-xl md:text-3xl font-bold text-emerald-900">Moderation <span className="ml-2 mr-3">{`>`}</span><span className="sm:hidden"><br></br></span><span className="text-lg md:text-3xl mx-2 font-medium underline underline-offset-4 decoration-emerald-500">{mode}</span></p>
            </div>
            {isLoading &&
                <div className="flex justify-center text-2xl ">
                    <AiOutlineLoading3Quarters className="loading"></AiOutlineLoading3Quarters>
                </div>
            }
            {noRequests &&
                <p className=" text-xl md:text-3xl font-bold text-emerald-900 text-center mt-16">No request pending</p>
            }
            {!isLoading && !noRequests &&
                <div className="flex flex-col mt-8">
                    <div className="flex flex-col md:flex-row bg-emerald-900/5 rounded-lg py-4 px-8 items-center">
                        <p className="text-lg font-medium mr-4">Submitted by: </p>
                        <div onClick={() => getUserProfile()} className="rounded-md bg-emerald-900 flex items-center px-2 py-2 cursor-pointer">
                            <img alt="" src="/user.png" className="aspect-square max-h-10 invert mx-1"></img>
                            <p className="text-white font-medium mx-1">{`${submitter.firstName} ${submitter.lastName}`}</p>
                        </div>
                    </div>

                    {modalOn &&
                        <div className="fixed top-0 left-0 h-full w-full bg-black/30">
                            <div className="rounded-lg absolute top-1/2 left-1/2 -translate-x-1/2 -translate-y-1/2 bg-white">
                                <div className="flex flex-col self-center lg:self-start bg-emerald-900/5 p-4 md:p-6">
                                    <div className="flex justify-end text-2xl">
                                        <IoClose className="cursor-pointer" onClick={() => { setModalOn(false) }}></IoClose>
                                    </div>
                                    {profileImage}
                                    <div className="mt-4 md:ml-6">
                                        <ProfileDetails icon={<IoPersonOutline></IoPersonOutline>} id="profile-name" content={`${person.first_name} ${person.last_name}`}></ProfileDetails>
                                        <ProfileDetails icon={<IoAtOutline></IoAtOutline>} id="profile-email" content={`${person.email}`}></ProfileDetails>
                                        <ProfileDetails icon={<IoStarOutline></IoStarOutline>} id="profile-reputation" content={`${person.reputation}`}></ProfileDetails>
                                    </div>
                                    <div className="flex flex-col shrink grow-0 mt-8">
                                        <button onClick={() => { setAutoApproval() }} className="p-3 bg-emerald-900 self-center text-xs md:text-base text-white rounded-full font-medium">
                                            Set auto-approval {person.auto_approval ? "Off" : "On"}
                                        </button>
                                    </div>
                                </div>
                            </div>
                        </div>
                    }

                    <div className="mt-8 bg-emerald-900/5 rounded-lg py-4 px-8 ">
                        <p className="text-xl md:text-3xl font-bold text-emerald-900 mb-4">Pictures</p>
                        <div className="md:flex">
                            <div className="flex justify-center items-center my-8 md:my-0 md:mr-32 h-[250px] lg:h-auto self-center">
                                <img alt="" src={photos[currentPhoto]} className="rounded-lg object-scale-down md:h-[300px] md:w-[300px] lg:h-[400px] lg:w-[400px]"></img>
                            </div>
                            <div className="grid grid-cols-2 lg:grid-cols-3 lg:grid-rows-3 gap-1.5 lg:grid-flow-col">
                                {
                                    photos.map((image, index) => {
                                        return (
                                            <div className="flex justify-center items-center"
                                                key={index}
                                            >
                                                <img
                                                    alt=''
                                                    src={image}
                                                    id={`moderation-camellia-image-${index}`}
                                                    className={"h-[75px] w-[75px] md:h-[100px] md:w-[100px] object-cover rounded" + (index === 0 ? " current" : "")}
                                                    onClick={() => { changeAmplified(index) }}
                                                ></img></div>)
                                    })
                                }
                            </div>
                        </div>
                    </div>

                    <div className="flex flex-col-reverse lg:flex-row mt-8 justify-between mb-8">
                        <div className="flex-auto lg:mr-16 w-full lg:w-[40%] mt-8 lg:mt-0">
                            <div className="bg-emerald-900/5 rounded-lg p-4 md:py-4 md:px-8 ">
                                <p className="font-bold text-xl md:text-3xl text-emerald-900 mb-6">Characteristics</p>
                                {
                                    characteristics.map((characteristic, index) => {
                                        return (<CharacteristicDropdown
                                            key={index}
                                            characteristic={characteristic.characteristic.upovCategory.name}
                                            down={false}
                                            details={{ characteristic: characteristic.characteristic.name, value: characteristic.descriptor }}
                                        ></CharacteristicDropdown>)
                                    })
                                }
                            </div>
                            <div className="bg-emerald-900/5 rounded-lg py-4 px-8 my-8">
                                <p className="text-xl md:text-3xl font-bold text-emerald-900">Decision</p>
                                <textarea className="w-full h-[150px] mt-4 resize-none md:text-lg p-2 font-light"></textarea>
                                <div className="flex flex-col sm:flex-row justify-center items-center mt-2">
                                    <div 
                                    onClick={()=>deleteRequest()}
                                    className=" bg-red-600 py-1 px-2 mx-4 my-2 rounded-md flex items-center cursor-pointer text-white text-lg"
                                    ><IoClose></IoClose>Decline</div>
                                    <div
                                        onClick={() => acceptRequest()}
                                        className="bg-emerald-500 py-1 px-2 mx-4 my-2 rounded-md flex items-center cursor-pointer text-white text-lg"
                                        ><IoCheckmark></IoCheckmark> Accept</div>
                                </div>
                            </div>

                        </div>
                        <div className="flex-1">
                            <div className="bg-emerald-900/5 rounded-lg py-4 px-8">
                                <p className="text-3xl font-bold text-emerald-900">Details</p>
                                <div className="ml-2">
                                    <p className="mt-4 text-lg underline underline-offset-1">Owner</p>
                                    <p className="mt-2 mb-1 font-medium">{specimen.owner}</p>
                                    <p className="mt-4 text-lg underline underline-offset-1">Garden</p>
                                    <p className="mt-2 mb-1 font-medium">{specimen.garden}</p>
                                    <p className="mt-4 text-lg underline underline-offset-1">Location</p>
                                    <Map className="mt-3" lat={specimen.latitude} lon={specimen.longitude} zoom={15} height={300} width={300}></Map>
                                </div>
                            </div>

                        </div>

                    </div>
                </div>
            }
        </div>
    )
}




export default Moderation