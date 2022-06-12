import React, { useState, useEffect } from 'react'
import { useNavigate } from 'react-router-dom';
import { IoSearch, IoCloseCircleOutline } from "react-icons/io5";
import { AiOutlineLoading3Quarters } from 'react-icons/ai'
import axios from 'axios'

import Sugestion from "../../components/Sugestion"
import CardList from '../../components/CardList';

const Encyclopedia = () => {

    const navigate = useNavigate();
    const [page, setPage] = useState("1");
    const [lastPage, setLastPage] = useState(1);
    const [camellias, setCamellias] = useState([]);
    const [fetched, setFetched] = useState(false);
    const [searchText, setSearchText] = useState("");
    const [sugestionsOn, setSugestionsOn] = useState(false);
    const [autocompletedCamellias, setAutocompletedCamellias] = useState([]); //
    const [sugestion, setSugestion] = useState({});
    const [chosenSugestion, setChosenSugestion] = useState(false);
    const [isLoading, setIsLoading] = useState(false);

    let noShadowSearch = `shadow-none border-x-0 border-b-0`;

    useEffect(() => {
        if (!fetched) {
            axios.get('/api/public/cultivars', { params: { page: page - 1 } })
                .then((response) => {
                    console.log(response.data)
                    setCamellias(response.data.content)
                    setLastPage(response.data.totalPages)
                    setFetched(true)
                })
                .catch((error) => {
                    console.log(error)
                })
        }
    })


    const getAutocompleteOnChange = (e) => {
        setSearchText(e.target.value)
        if (e.target.value.length > 2) {
            setSugestionsOn(true)
            axios.get('/api/public/autocomplete', { params: { substring: e.target.value } })
                .then((response) => {
                    setAutocompletedCamellias(response.data)
                })
                .catch((error) => {
                    console.log(error)
                })
        }
        else {
            setSugestionsOn(false)
        }
    }



    const setSugestionClicked = (sugest) => {
        setSearchText(sugest.denomination);
        setSugestionsOn(false);
        setChosenSugestion(true);
        setSugestion(sugestion);
    }



    const clearAll = () => {
        axios.get('/api/public/cultivars', { params: { page: page-1 } })
            .then((response) => {
                setCamellias(response.data.content)
                setFetched(true)
                setSearchText("")
                setChosenSugestion(false)
                setSugestionsOn(false)
            })
            .catch((error) => {
                console.log(error)
            })

    }

    const searchCultivar = async () => {
        if (searchText === "") {
            clearAll();
            return;
        }
        const options = {
            params: {
                page: page - 1,
                search: searchText
            }
        }
        await axios.get('/api/public/cultivars', options)
            .then((response) => {
                setIsLoading(true);
                setSugestionsOn(false);
                setChosenSugestion(true);
                setTimeout(() => {
                    setCamellias(response.data.content);
                    setIsLoading(false);
                }, 500)
            })

            .catch((error) => {
                console.log(error)
            })




    }

    const changePage = (index) => {
        setFetched(false);
        setPage(index);
    }


    const redirect = (route) => {
        navigate(route);
    }


    const changePageInput = (e) => {

        if (!/[a-zA-Z]/.test(e.target.value)) {
            setPage(e.target.value);
            if (Number.parseInt(e.target.value) > 0) {
                setFetched(false);
            }
        }
    }


    return (
        <div className="container-4/5 mt-16 mb-8 flex flex-col">
            <div className="pb-6 ml-4">
                <p className="text-3xl font-bold text-center md:text-start fade-in" style={{ animationDelay: `100ms` }}>Encyclopedia</p>
            </div>
            <div className="self-center flex flex-col w-full pt-4 fade-in" style={{ animationDelay: `200ms` }}>
                <div className="flex w-full relative">

                    <div className=" flex w-11/12 mr-2 md:mr-4 relative sm:text-base md:text-xl" >
                        {sugestionsOn &&
                            <div className=" w-full top-[50%] pt-8 pb-2 rounded-b-xl absolute bg-white shadow-md">
                                {autocompletedCamellias.map((ac, index) => (
                                    <Sugestion className="flex md:text-xl text-base py-2 cursor-pointer px-4 hover:bg-slate-50" setSugestionClicked={(search) => setSugestionClicked(search)} key={index} cultivar={ac} />
                                ))}
                            </div>
                        }
                        <input
                            value={searchText}
                            onChange={(e) => { getAutocompleteOnChange(e) }}
                            placeholder="Search for a cultivar"
                            className={`z-[1] rounded-3xl border-2 px-4 py-2 shadow w-full h-full outline-none ${sugestionsOn && noShadowSearch}`}
                        >
                        </input>
                        {searchText !== "" && <IoCloseCircleOutline onClick={() => { clearAll() }} className="absolute z-[2] top-[30%] right-4 text-emerald-900"></IoCloseCircleOutline>}
                    </div>
                    <button onClick={() => { searchCultivar() }} className="bg-emerald-900 text-white text-2xl px-4 md:px-6 py-1 rounded-3xl active:scale-95 hover:scale-105"><IoSearch></IoSearch></button>
                </div>
                <div className=" flex md:justify-start mt-4">
                    <button className="bg-emerald-900 text-white font-light text-base md:text-lg px-4 md:px-6 py-1 mx-1 md:mx-4 rounded-3xl active:scale-95">Filter By</button>
                    <button className="bg-emerald-900 text-white font-light text-base md:text-lg px-4 md:px-6 py-1 mx-1 md:mx-4 rounded-3xl active:scale-95">Sort By</button>
                </div>
            </div>

            {isLoading ?


                <div className="my-28 flex justify-center">
                    <AiOutlineLoading3Quarters className="loading text-emerald-900 text-4xl"></AiOutlineLoading3Quarters>
                </div>

                :
                <div className="grid sm:grid-cols-2 sm:gap-x-4 md:grid-cols-3 md:grid-rows-3 md:gap-x-8 gap-y-10 mt-10">
                    <CardList camellias={camellias} baseDelay={200} redirect={redirect} chosenSugestion={chosenSugestion}></CardList>
                </div>}
            {!chosenSugestion &&
                <div className="flex justify-center mt-12 fade-in" style={{ animationDelay: `1200ms` }}>
                    <button className="bg-emerald-900/5 rounded-lg py-1.5 px-4 mr-4" onClick={() => changePage(1)}>First</button>

                    <button className="bg-emerald-900/5 py-1.5 px-3 rounded-tl-lg rounded-bl-lg" onClick={() => changePage(Number.parseInt(page) - 1)}> {"<"} </button>
                    <input className=" text-center bg-emerald-900/5 outline-none py-1.5" value={page} onChange={changePageInput}></input>
                    <button className="bg-emerald-900/5 py-1.5 px-3 rounded-tr-lg rounded-br-lg" onClick={() => changePage(Number.parseInt(page) + 1)}> {">"} </button>

                    <button className="bg-emerald-900/5 rounded-lg py-1.5 px-4 ml-4" onClick={() => changePage(lastPage)}>Last</button>
                </div>

            }

        </div>
    )
}





export default Encyclopedia