import React, { useState } from 'react';
import { useDispatch, useSelector } from 'react-redux';
import { IoAddCircle } from 'react-icons/io5';
import axios from 'axios';
import sha256 from 'crypto-js/sha256';
import Base64 from 'crypto-js/enc-base64';
import { BlobServiceClient } from "@azure/storage-blob";


import { tokenTtl } from '../../utilities/ttl';
import { signedIn, signOut } from '../../redux/actions'



const ProfileEditCard = (props) => {

    const account = "camelliacultivar";
    const sasKey = "?sv=2021-06-08&ss=bfqt&srt=sco&sp=rwdlacupitfx&se=2022-06-14T00:10:33Z&st=2022-06-13T16:10:33Z&sip=0.0.0.0-255.255.255.255&spr=https,http&sig=3WV16o6czdJD8Sw9wCwonIv8rYnvqtDQHsbqyIDW45s%3D";

    const blobServiceClient = new BlobServiceClient(
        `https://${account}.blob.core.windows.net${sasKey}`,
    );

    const containerName = `camelliacultivar`

    const [changePassword, setChangePassword] = useState(false);
    const [passwordNeeded, setPasswordNeeded] = useState(false);
    const [wrongFileType, setWrongFileType] = useState(false);
    const [newPassword, setNewPassword] = useState("");
    const [confirmNewPassword, setConfirmNewPassword] = useState("");
    const [password, setPassword] = useState("");
    const [newFirstName, setNewFirstName] = useState(props.person.first_name);
    const [newLastName, setNewLastName] = useState(props.person.last_name);
    const user = useSelector(state => state.user);
    const [profilePicture, setProfilePicture] = useState(user.profile_photo);


    const dispatch = useDispatch();


    const saveProfile = async () => {
        let tempUser = { ...props.person }
        setPasswordNeeded(false);
        if (password !== '' && await verifyLogin(tempUser.email, password)) {
            tempUser['first_name'] = newFirstName
            tempUser['last_name'] = newLastName
            dispatch(signedIn(tempUser))
            let editedUser = {
                first_name: newFirstName,
                last_name: newLastName,
                email: tempUser.email,
                password: password,
                profile_photo: profilePicture
            }
            if (changePassword && (newPassword === confirmNewPassword) && (newPassword !== "")) {
                editedUser['password'] = Base64.stringify((sha256(newPassword)));
            }
            await sendEditedUser(editedUser);
            setPasswordNeeded(false);
            props.setIsEditing(false);

        } else {
            setPasswordNeeded(true);
        }

    }

    const uploadToServer = async (file) => {
        const containerClient = blobServiceClient.getContainerClient(containerName);
        try {
            const blockBlobClient = containerClient.getBlockBlobClient(file.name);
            await blockBlobClient.uploadData(file);
        }
        catch (error) {
            console.error(error.message);
        }
    }

    const sendEditedUser = (editedUser) => {
        const loggedInUser = localStorage.getItem("userToken");
        const file = 0;
        if (loggedInUser) {
            const userToken = JSON.parse(localStorage.getItem("userToken"));
            if (userToken.expiry > Date.now()) {
                axios.put(`/api/users/${userToken.userId}`, editedUser, {
                    headers: {
                        "Authorization": `Bearer ${userToken.loginToken}`,
                    }
                })
                    .catch(function (_error) {
                        return;
                    });
                uploadToServer(file);
            } else {
                localStorage.removeItem("userToken");
                dispatch(signOut());
            }
        }
    }

    const verifyLogin = (email, _password) => {
        let body = { email: email, password: _password };
        return axios.post('/api/users/login', body)
            .then(function (response) {
                if ((response.status === 200) && window.localStorage) {
                    if (response.data === '') {
                        setPasswordNeeded(true);
                        return false;
                    } else {
                        const token = { userId: response.data.split(' ')[0], loginToken: response.data.split(' ')[1], expiry: Date.now() + tokenTtl }
                        localStorage.setItem("userToken", JSON.stringify(token));
                        setPasswordNeeded(false);
                        return true;
                    }
                }
            })
            .catch(function (_error) {
                return false;
            });
    }

    const setPhoto = (e) => {
        setWrongFileType(false);
        console.log(e.target.files[0])
        if (e.target.files[0].type.includes("image")) {
            let imgUrl = `https://${account}.blob.core.windows.net/${containerName}/${e.target.files[0].name}`
            setProfilePicture(imgUrl);
            let tempUser = { ...props.person }
            tempUser['profile_image'] = URL.createObjectURL(e.target.files[0])
            dispatch(signedIn(tempUser));
        } else {
            setWrongFileType(true);
        }
    }

    const addPhoto = () => {
        document.getElementById("editProfilePicture").click();
    }

    return (
        <div className="flex flex-col rounded-xl bg-emerald-900/5 p-6 mb-8 pop-in" style={{ animationDelay: `200ms` }}>
            <div className="relative">
                {props.person.profile_image === "null" ?
                    <svg xmlns="http://www.w3.org/2000/svg" className="h-[150px] w-[150px] md:h-[300px] md:w-[300px] mx-auto" viewBox="0 0 20 20" fill="currentColor">
                        <path fillRule="evenodd" d="M18 10a8 8 0 11-16 0 8 8 0 0116 0zm-6-3a2 2 0 11-4 0 2 2 0 014 0zm-2 4a5 5 0 00-4.546 2.916A5.986 5.986 0 0010 16a5.986 5.986 0 004.546-2.084A5 5 0 0010 11z" clipRule="evenodd" />
                    </svg>
                    : <img alt="" className=" rounded-full aspect-square object-cover h-[150px] w-[150px] md:h-[300px] md:w-[300px] border-2 md:border-4 border-emerald-900 mx-auto" src={props.person.profile_image}></img>}
                <div className="absolute text-emerald-900 left-1/2 bottom-0 translate-x-[50%] ">
                    <IoAddCircle onClick={() => { addPhoto() }} className="h-10 w-10 cursor-pointer bg-primary-transparent rounded-full"></IoAddCircle>
                    <input type="file" className=" hidden" id="editProfilePicture" onChange={(e) => { setPhoto(e) }}></input>
                </div>
            </div>
            {wrongFileType && <p className="text-red-800 text-sm md:text-base ml-4 mt-2">Wrong file type!</p>}
            <div className="mt-4">
                <div className="container-4/5 flex flex-col justify-center mt-6 text-2xl font-medium text-emerald-900">
                    <div className="flex flex-col">
                        <label className=" text-base md:text-lg" htmlFor='editProfile-firstName'>First Name</label>
                        <input
                            value={newFirstName}
                            className="mt-2 text-base md:text-lg lg:text-xl py-2 px-4 rounded-full"
                            id="editProfile-firstName"
                            onChange={(e) => {
                                setNewFirstName(e.target.value)
                            }}
                        ></input>
                    </div>
                    <div className="mt-4 flex flex-col">
                        <label className=" text-base md:text-lg" htmlFor='editProfile-lastName'>Last Name</label>
                        <input
                            value={newLastName}
                            className="mt-2 text-base md:text-lg lg:text-xl py-2 px-4 rounded-full"
                            id="editProfile-lastName"
                            onChange={(e) => {
                                setNewLastName(e.target.value)
                            }}
                        ></input>
                    </div>
                    <div className="mt-4 flex flex-col">
                        <label className=" text-base md:text-lg">Password</label>
                        <input
                            type="password"
                            className="mt-2 text-base md:text-lg lg:text-xl py-2 px-4 rounded-full"
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
                                <label className=" text-base md:text-lg">New Password</label>
                                <input
                                    type="password"
                                    className="mt-2 text-base md:text-lg lg:text-xl py-2 px-4 rounded-full"
                                    id="editProfile-newPassword"
                                    onChange={(e) => {
                                        setNewPassword(e.target.value)
                                    }}
                                ></input>
                            </div>
                            <div className="mt-4 flex flex-col">
                                <label className=" text-base md:text-lg">Confirm New Password</label>
                                <input
                                    type="password"
                                    className="mt-2 text-base md:text-lg lg:text-xl py-2 px-4 rounded-full"
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

            <div className="flex flex-col sm:flex-row items-center justify-center">
                <button onClick={() => { saveProfile() }} className="p-3 bg-emerald-900 text-white rounded-full mt-6 font-medium mx-2">
                    Save Profile
                </button>
                <button onClick={() => { props.setIsEditing(false) }} className="py-2.5 px-3 border-2 border-emerald-900 text-emerald-900 rounded-full mt-6 font-medium mx-2">
                    Cancel
                </button>
            </div>
        </div>
    )
}

export default ProfileEditCard