import React from 'react'
import { IoPersonOutline, IoAtOutline, IoStarOutline } from 'react-icons/io5'
import ProfileDetails from '../ProfileDetails'


const ProfileCard = (props) => {
    return (
        <div className="flex flex-col self-center lg:self-start rounded-xl bg-emerald-900/5 p-4 md:p-6 fade-in" style={{ animationDelay: `200ms` }}>
            {props.person.profile_image === "null" ?
                <svg xmlns="http://www.w3.org/2000/svg" className="h-[150px] w-[150px] md:h-[300px] md:w-[300px] self-center" viewBox="0 0 20 20" fill="currentColor">
                    <path fillRule="evenodd" d="M18 10a8 8 0 11-16 0 8 8 0 0116 0zm-6-3a2 2 0 11-4 0 2 2 0 014 0zm-2 4a5 5 0 00-4.546 2.916A5.986 5.986 0 0010 16a5.986 5.986 0 004.546-2.084A5 5 0 0010 11z" clipRule="evenodd" />
                </svg>
                : <img alt="" className=" rounded-full aspect-square object-cover h-[150px] w-[150px] md:h-[300px] md:w-[300px] border-4 border-emerald-900 self-center" src={props.person.profile_image}></img>}
            <div className="mt-4 md:ml-6">
                <ProfileDetails icon={<IoPersonOutline></IoPersonOutline>} id="profile-name" content={`${props.person.first_name} ${props.person.last_name}`}></ProfileDetails>
                <ProfileDetails icon={<IoAtOutline></IoAtOutline>} id="profile-email" content={`${props.person.email}`}></ProfileDetails>
                <ProfileDetails icon={<IoStarOutline></IoStarOutline>} id="profile-reputation" content={`${props.person.reputation}`}></ProfileDetails>
            </div>
            <div className="flex flex-col">
                <button onClick={() => { props.setIsEditing(true) }} className="p-3 bg-emerald-900 self-center text-xs md:text-base text-white rounded-full mt-8 md:mt-14 font-medium">
                    Edit Profile
                </button>
            </div>
        </div>
    )
}

export default ProfileCard