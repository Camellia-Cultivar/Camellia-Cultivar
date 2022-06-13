import React from 'react'

const ProfileDetails = (props) => {


    
  return (
    <div id={props.id} className="flex items-center mt-2 md:mt-6 text-lg md:text-2xl font-medium text-emerald-900">
                        {props.icon}
                        {props.editing ? 
                        <input
                            value={props.content}
                        className="ml-8 text-xl text-center"
                    ></input>
                        :<p
                            
                            className="ml-4 text-sm md:text-xl text-center"
                        > {props.content}</p>}
                    </div>
  )
}

export default ProfileDetails