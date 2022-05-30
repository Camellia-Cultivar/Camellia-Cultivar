import React, { useState } from 'react'
import { useDispatch, useSelector } from 'react-redux'
import axios from 'axios'
import { IoAddCircle } from 'react-icons/io5'


import { signedIn, signOut } from '../../redux/actions'



const ProfileEditCard = (props) => {

    const [profilePicture, setProfilePicture] = useState("null");
    const [changePassword, setChangePassword] = useState(false);
    const [passwordNeeded, setPasswordNeeded] = useState(false);
    const [newPassword, setNewPassword] = useState("");
    const [confirmNewPassword, setConfirmNewPassword] = useState("");
    const [password, setPassword] = useState("");
    const [newFirstName, setNewFirstName] = useState(props.person.first_name);
    const [newLastName, setNewLastName] = useState(props.person.last_name);

    const dispatch = useDispatch();
    const user = useSelector(state => state.user)




    const saveProfile = () => {
        setPasswordNeeded(false);
        if (password !== '') {
            if (changePassword && (newPassword === confirmNewPassword) && (newPassword !== "")) {
                let tempUser = { ...props.person }
                tempUser['first_name'] = newFirstName
                tempUser['last_name'] = newLastName
                dispatch(signedIn(tempUser))
                console.log(user);
                let editedUser = {
                    first_name: newFirstName,
                    last_name: newLastName,
                    email: tempUser.email,
                    password: newPassword,
                    profile_photo: user.profile_image
                }
                const loggedInUser = localStorage.getItem("userToken");
                if (loggedInUser) {
                    const userToken = JSON.parse(localStorage.getItem("userToken"));
                    if (userToken.expiry > Date.now()) {
                        axios.put(`/api/users`, editedUser, {
                            headers: {
                                "Authorization": `Bearer ${userToken.loginToken}`,
                            }
                        })
                            .then(function (response) {
                                console.log(response);
                            })
                            .catch(function (error) {
                                console.log(error);
                            });
                    } else {
                        localStorage.removeItem("userToken");
                        dispatch(signOut());
                    }

                }
            }
            else {
                let tempUser = { ...props.person }
                tempUser['first_name'] = newFirstName
                tempUser['last_name'] = newLastName
                dispatch(signedIn(tempUser))
                let editedUser = {
                    first_name: newFirstName,
                    last_name: newLastName,
                    email: tempUser.email,
                    password: password,
                    profile_photo: user.profile_image
                }
                const loggedInUser = localStorage.getItem("userToken");
                if (loggedInUser) {
                    const user = JSON.parse(localStorage.getItem("userToken"));
                    if (user.expiry > Date.now()) {
                        console.log(editedUser);

                        axios.put(`/api/users`, editedUser, {
                            headers: {
                                "Authorization": `Bearer ${user.loginToken}`,
                            }
                        })
                            .then(function (response) {
                                console.log(response);
                            })
                            .catch(function (error) {
                                console.log(error);
                            });
                    } else {
                        localStorage.removeItem("userToken");
                        dispatch(signOut());

                    }

                }
            }


            setPasswordNeeded(false);
            props.setIsEditing(false);
        } else {
            setPasswordNeeded(true);
        }

    }

    const setDetails = (detail, value) => {

    }

    const addPhoto = () => {
        document.getElementById("editProfilePicture").click();
    }

    const setPhoto = (e) => {
        let imgUrl = URL.createObjectURL(e.target.files[0])
        let tempUser = { ...props.person }
        tempUser['profile_image'] = imgUrl
        setProfilePicture(imgUrl)
        dispatch(signedIn(tempUser));

    }

    return (
        <div className="flex flex-col rounded-xl bg-emerald-900/5 p-6 mb-8">
            <div className="relative">
                {props.person.profile_image === "null" ?
                    <svg xmlns="http://www.w3.org/2000/svg" className="h-[300px] w-[300px] mx-auto" viewBox="0 0 20 20" fill="currentColor">
                        <path fillRule="evenodd" d="M18 10a8 8 0 11-16 0 8 8 0 0116 0zm-6-3a2 2 0 11-4 0 2 2 0 014 0zm-2 4a5 5 0 00-4.546 2.916A5.986 5.986 0 0010 16a5.986 5.986 0 004.546-2.084A5 5 0 0010 11z" clipRule="evenodd" />
                    </svg>
                    : <img alt="" className=" rounded-full aspect-square object-cover h-[300px] w-[300px] border-4 border-emerald-900 mx-auto" src={props.person.profile_image}></img>}
                <div className="absolute text-emerald-900 right-0 bottom-0 -translate-x-[50px] -translate-y-[20px]">
                    <IoAddCircle onClick={() => { addPhoto() }} className="h-10 w-10 cursor-pointer bg-primary-transparent rounded-full"></IoAddCircle>
                    <input type="file" className=" hidden" id="editProfilePicture" onChange={(e) => { setPhoto(e) }}></input>
                </div>
            </div>
            <div className="mt-4">
                <div className="container-4/5 flex flex-col justify-center mt-6 text-2xl font-medium text-emerald-900">
                    <div className="flex flex-col">
                        <label className="text-lg" htmlFor='editProfile-firstName'>First Name</label>
                        <input
                            value={newFirstName}
                            className="mt-2 text-xl py-2 px-4 rounded-full"
                            id="editProfile-firstName"
                            onChange={(e) => {
                                setNewFirstName(e.target.value)
                            }}
                        ></input>
                    </div>
                    <div className="mt-4 flex flex-col">
                        <label className="text-lg" htmlFor='editProfile-lastName'>Last Name</label>
                        <input
                            value={newLastName}
                            className="mt-2 text-xl py-2 px-4 rounded-full"
                            id="editProfile-lastName"
                            onChange={(e) => {
                                setNewLastName(e.target.value)
                            }}
                        ></input>
                    </div>
                    <div className="mt-4 flex flex-col">
                        <label className="text-lg">Password</label>
                        <input
                            type="password"
                            className="mt-2 text-xl py-2 px-4 rounded-full"
                            id="editProfile-password"
                            onChange={(e) => {
                                setPassword(e.target.value)
                            }}
                        ></input>
                        {passwordNeeded && <p className="font-medium text-sm text-red-700 text-center mt-4">Insert your password to confirm changes</p>}
                    </div>
                    {changePassword ?
                        <>
                            <div className="mt-4 flex flex-col">
                                <label className="text-lg">New Password</label>
                                <input
                                    type="password"
                                    className="mt-2 text-xl py-2 px-4 rounded-full"
                                    id="editProfile-newPassword"
                                    onChange={(e) => {
                                        setNewPassword(e.target.value)
                                    }}
                                ></input>
                            </div>
                            <div className="mt-4 flex flex-col">
                                <label className="text-lg">Confirm New Password</label>
                                <input
                                    type="password"
                                    className="mt-2 text-xl py-2 px-4 rounded-full"
                                    id="editProfile-confirmNewPassword"
                                    onChange={(e) => {
                                        setConfirmNewPassword(e.target.value)
                                    }}
                                ></input>
                            </div>
                        </>
                        :
                        <div className="flex flex-col text-base items-center">
                            <button onClick={() => { setChangePassword(true) }} className="p-3 bg-emerald-900 self-center text-white rounded-full mt-6 font-medium">
                                Change Password
                            </button>
                        </div>

                    }
                </div>
            </div>

            <div className="flex justify-center">
                <button onClick={() => { saveProfile() }} className="p-3 bg-emerald-900 text-white rounded-full mt-6 font-medium mx-2">
                    Save Profile
                </button>
                <button onClick={() => { props.setIsEditing(false) }} className="p-3 border-2 border-emerald-900 text-emerald-900 rounded-full mt-6 font-medium mx-2">
                    Cancel
                </button>
            </div>
        </div>
    )
}

export default ProfileEditCard