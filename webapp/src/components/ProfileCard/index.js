import React from 'react'
import {IoPersonOutline, IoAtOutline, IoStarOutline} from 'react-icons/io5'
import ProfileDetails from '../ProfileDetails'


const ProfileCard = (props) => {
  return (
    <div className="flex flex-col rounded-xl bg-emerald-900/5 p-6">
                    <img alt="" className=" rounded-full aspect-square object-cover h-[300px] w-[300px] border-4 border-emerald-900 self-center" src={props.person.picture}></img>
                    <div className="ml-6 mt-4">
                        <ProfileDetails icon={<IoPersonOutline></IoPersonOutline>} id="profile-name" content={`${props.person.firstName} ${props.person.lastName}`}></ProfileDetails>
                        <ProfileDetails icon={<IoAtOutline></IoAtOutline>} id="profile-email" content={`${props.person.email}`}></ProfileDetails>
                        <ProfileDetails icon={<IoStarOutline></IoStarOutline>} id="profile-reputation" content={`${props.person.reputation}`}></ProfileDetails>
                    </div>
                    <div className="flex flex-col">
                        <button onClick={()=>{props.setIsEditing(true)}} className="p-3 bg-emerald-900 self-center text-white rounded-full mt-6 font-medium">
                            Edit Profile
                        </button>
                        <button className="p-3 bg-emerald-900 self-center text-white rounded-full mt-6 font-medium">
                            Change Password
                        </button>

                    </div>
                </div>
  )
}

export default ProfileCard