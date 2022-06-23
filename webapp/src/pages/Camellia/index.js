import React, { useState, useEffect } from 'react'
import { useParams } from 'react-router-dom'
import CamelliaCategory from '../../components/CamelliaCategory';
import { BiImages } from "react-icons/bi";
import axios from 'axios';

import CharacteristicDropdown from '../../components/CharacteristicDropdown';
import AnimateHeight from 'react-animate-height';
import { proxy } from '../../utilities/proxy';
const Camellia = () => {


    const [camellia, setCamellia] = useState({});
    const [moreLoaded, setMoreLoaded] = useState(false);
    const [height, setHeight] = useState(0);
    const [fetched, setFetched] = useState(false);
    const [characteristics, setCharacteristics] = useState([]);
    const [otherPhotos, setOtherPhotos] = useState([]);
    const [otherPhotosExist, setOtherPhotosExist] = useState(false);




    const params = useParams()


    useEffect(() => {
        if (!fetched) {
            axios.get(`${proxy}/api/public/cultivars/${params.id}`)
                .then((response) => {
                    setCharacteristics(response.data.characteristicValues)
                    setCamellia(response.data)
                    setFetched(true);
                })
                .catch((err) => {
                    console.error(err)
                })

        }
    })

    const loadMore = () => {
        axios.get(`${proxy}/api/public/cultivars/${camellia.id}/photos`)
            .then((response) => {
                let tempPhotos = [];
                setOtherPhotosExist(response.data.content.length === 0);
                for (const photo of response.data.content) {
                    tempPhotos.push(<div className="flex justify-center">
                    <img className="max-h-40 object-cover rounded-md shadow" alt="" src={photo}></img>
                </div>)
                }
                setOtherPhotos(tempPhotos);
            })
            .catch((err) => {
                console.error(err)
            })
        height === 'auto' ? setTimeout(() => { setMoreLoaded(!moreLoaded) }, 305) : setMoreLoaded(!moreLoaded);
        setHeight(
            height === 0 ? 'auto' : 0
        )
    }


    return (
        <div className="mt-8 sm:mt-16 mb-8 mx-4 sm:container-4/5 flex flex-col md:flex-row justify-between">
            <div className="grid auto-rows-min md:w-1/2">
                <div >
                    <p className="text-5xl font-semibold text-emerald-900">
                        {camellia.epithet}
                    </p>
                </div>
                <div className="mt-8 w-full bg-emerald-900/5 rounded-lg p-4">
                    <p className="font-bold text-3xl text-emerald-900 mb-6">Description</p>
                    <p className="text-emerald-900 text-justify">
                        {camellia.description}
                    </p>
                </div>
                <div className="mt-8 w-full bg-emerald-900/5 rounded-lg p-4">
                    <p className="font-bold text-3xl text-emerald-900 mb-6">Characteristics</p>
                    {characteristics.length !== 0 ?
                        characteristics.map((characteristic, index) => {
                            return (<CharacteristicDropdown
                                key={index}
                                characteristic={characteristic.characteristic.upovCategory.name}
                                down={false}
                                details={{ characteristic: characteristic.characteristic.name, value: characteristic.descriptor }}
                            ></CharacteristicDropdown>)
                        })
                        :
                        <p className="text-emerald-900 text-justify">There are no characteristics to present</p>
                    }
                </div>
            </div>
            <div className="md:w-1/3 mt-8 md:mt-0">
                <div className="flex flex-col">
                    {camellia.photograph === null ?
                        <img src="/logo.svg" className="bg-emerald-900/20 self-center shadow-md rounded-lg object-cover w-11/12" alt="Logo"></img>
                        :
                        <img className="shadow-md self-center w-11/12 rounded-lg object-cover" src={camellia.photograph} alt={camellia.epithet}></img>
                    }
                    <CamelliaCategory description={camellia.species} category="Species / Combination" />
                    <CamelliaCategory description={`${camellia.species} '${camellia.epithet}'`} category="Scientific Name" />


                    <div className="bg-emerald-900/20 mt-8 rounded-full flex items-center justify-center py-4 text-emerald-900 cursor-pointer hover:scale-105" onClick={() => { loadMore() }}>
                        <BiImages></BiImages>
                        <p className="ml-2 text-center text-emerald-900">{moreLoaded ? "Hide" : "More Photos"}</p>
                    </div>
                    <AnimateHeight duration={500} height={height}>
                        {
                        moreLoaded &&
                        !otherPhotosExist?
                            <div className="grid gap-y-3 gap-x-2 md:gap-x-1 grid-cols-2 md:grid-cols-3 mt-8">
                                 {otherPhotos}
                            </div>
                            :
                            <p className=" text-center mt-2 ">There are no more photos</p>
                            }
                        
                    </AnimateHeight>

                </div>
            </div>

        </div>
    )

}

export default Camellia;
