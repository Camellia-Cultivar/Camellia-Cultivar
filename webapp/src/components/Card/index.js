import React from 'react'

const Card = ({ className, image, name, species, identifications }) => {
    return (
        <div className={"rounded-lg "+className}>

        <div className=" bg-emerald-900/20 grid grid-cols-2 rounded-lg">
            <div className="m-4">
                <img alt="" className="rounded-lg aspect-square" src={image}></img>
            </div>
            <div className="text-center flex flex-col justify-center align-middle h-full">
                <p className="font-semibold">{name}</p>
                <p className="text-xs font-medium">{species}</p>
                <p className="mt-3 text-xs">No. of identifications: {identifications}</p>
            </div>
        </div>
        </div>
    )
}

export default Card