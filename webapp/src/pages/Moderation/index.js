import React, { useState } from 'react'
import { IoClose, IoCheckmark } from 'react-icons/io5';

import CharacteristicDropdown from '../../components/CharacteristicDropdown/index.js';
import Map from '../../components/ModerationMap/index.js';

import user from './user.js'
import camellia from './sample.js'


const Moderation = () => {
    const [mode, setMode] = useState("Approve Requests");
    const [currentPhoto, setCurrentPhoto] = useState(0);


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
            <div className="flex flex-col mt-8">
                <div className="flex flex-col md:flex-row bg-emerald-900/5 rounded-lg py-4 px-8 items-center">
                    <p className="text-lg font-medium mr-4">Submitted by: </p>
                    <div className="rounded-md bg-emerald-900 flex items-center px-2 py-2 cursor-pointer">
                        <img alt="" src="/user.png" className="aspect-square max-h-10 invert mx-1"></img>
                        <p className="text-white font-medium mx-1">{`${user.firstName} ${user.lastName}`}</p>
                    </div>
                </div>
                <div className="mt-8 bg-emerald-900/5 rounded-lg py-4 px-8 ">
                    <p className="text-xl md:text-3xl font-bold text-emerald-900 mb-4">Pictures</p>
                    <div className="md:flex">
                        <div className="flex justify-center items-center my-8 md:my-0 md:mr-32 h-[250px] lg:h-auto self-center">
                            <img alt="" src={camellia.otherImages[currentPhoto]} className="rounded-lg object-scale-down md:h-[300px] md:w-[300px] lg:h-[400px] lg:w-[400px]"></img>
                        </div>

                        <div className="grid grid-cols-2 lg:grid-cols-3 lg:grid-rows-3 gap-1.5 lg:grid-flow-col">
                            {
                                camellia.otherImages.map((image, index) => {
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
                            <CharacteristicDropdown characteristic="Plant" down={false} details={camellia.plant}></CharacteristicDropdown>
                            <CharacteristicDropdown characteristic="Size" down={false} details={camellia.size}></CharacteristicDropdown>
                            <CharacteristicDropdown characteristic="Flower" down={false} details={camellia.flower}></CharacteristicDropdown>
                            <CharacteristicDropdown characteristic="Folliage" down={false} details={camellia.folliage}></CharacteristicDropdown>
                        </div>
                        <div className="bg-emerald-900/5 rounded-lg py-4 px-8 my-8">
                            <p className="text-xl md:text-3xl font-bold text-emerald-900">Decision</p>
                            <textarea className="w-full h-[150px] mt-4 resize-none md:text-lg p-2 font-light"></textarea>
                            <div className="flex flex-col sm:flex-row justify-center items-center mt-2">
                                <div className=" bg-red-600 py-1 px-2 mx-4 my-2 rounded-md flex items-center cursor-pointer text-white text-lg"><IoClose></IoClose>Decline</div>
                                <div className="bg-emerald-500 py-1 px-2 mx-4 my-2 rounded-md flex items-center cursor-pointer text-white text-lg"><IoCheckmark></IoCheckmark> Accept</div>
                            </div>
                        </div>

                    </div>
                    <div className="flex-1">
                        <div className="bg-emerald-900/5 rounded-lg py-4 px-8">
                            <p className="text-3xl font-bold text-emerald-900">Details</p>
                            <div className="ml-2">
                                <p className="mt-4 text-lg underline underline-offset-1">Owner</p>
                                <p className="mt-2 mb-1 font-medium">{camellia.owner}</p>
                                <p className="mt-4 text-lg underline underline-offset-1">Garden</p>
                                <p className="mt-2 mb-1 font-medium">{camellia.garden}</p>
                                <p className="mt-4 text-lg underline underline-offset-1">Location</p>
                                <Map className="mt-3" lat={40.63382613681027} lon={-8.650824423720795} zoom={16.25} height={300} width={300}></Map>
                            </div>
                        </div>

                    </div>

                </div>
            </div>
        </div>
    )
}




export default Moderation