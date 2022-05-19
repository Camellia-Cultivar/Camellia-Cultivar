import React from 'react'

const Card = ({ className, image, name, species, identifications, redirect }) => {

    return (
        <div className={"rounded-lg " + className} onClick={()=>{redirect(`camellia`)}}>

            <div className=" bg-emerald-900/20 grid grid-cols-2 rounded-lg">
                <div className="m-2 lg:m-4">
                    <img alt="" className="rounded-lg aspect-square" src={image}></img>
                </div>
                <div className="m-1 text-center flex flex-col justify-center align-middle h-full">
                    <p className="text-lg sm:text-base font-bold">{name}</p>
                    <p className="text-sm sm:text-xs font-medium">{species}</p>
                </div>
            </div>
        </div>
    )
}

export default Card