import React, { Component } from 'react'
import CamelliaCategory from '../../components/CamelliaCategory';
import { BiImages } from "react-icons/bi";

import sample from './sample'
import CharacteristicDropdown from '../../components/CharacteristicDropdown';
import AnimateHeight from 'react-animate-height';
export default class Camellia extends Component {
    constructor(props) {
        super(props);
        this.state = {
            camellia: sample,
            moreLoaded: false,
            height:0,
        }
    }

    loadMore = () => {
        const {height} = this.state;
        height==='auto' ? setTimeout(() =>{this.setState({moreLoaded:!this.state.moreLoaded})}, 305) : this.setState({moreLoaded:!this.state.moreLoaded});
        this.setState({
            height: height===0 ? 'auto':0
        })
    }

    render() {
        return (
            <div className="mt-16 mb-8 container-4/5 flex justify-between">
                <div className="grid auto-rows-min w-1/2">
                    <div >
                        <p className="text-5xl font-semibold text-emerald-900">
                            {this.state.camellia.name}
                        </p>
                    </div>
                    <div className="mt-8 w-full bg-emerald-900/5 rounded-lg p-4">
                        <p className="font-bold text-3xl text-emerald-900 mb-6">Description</p>
                        <p className="text-emerald-900 text-justify">
                            {this.state.camellia.description}
                        </p>
                    </div>
                    <div className="mt-8 w-full bg-emerald-900/5 rounded-lg p-4">
                        <p className="font-bold text-3xl text-emerald-900 mb-6">Characteristics</p>
                        <CharacteristicDropdown characteristic="Plant" down={false} details={this.state.camellia.plant}></CharacteristicDropdown>
                        <CharacteristicDropdown characteristic="Size" down={false} details={this.state.camellia.size}></CharacteristicDropdown>
                        <CharacteristicDropdown characteristic="Flower" down={false} details={this.state.camellia.flower}></CharacteristicDropdown>
                        <CharacteristicDropdown characteristic="Folliage" down={false} details={this.state.camellia.folliage}></CharacteristicDropdown>
                    </div>

                </div>
                <div className="w-1/3">
                    <div className="flex flex-col">
                        <img className="shadow-md self-center w-11/12 rounded-lg object-cover" src={this.state.camellia.image} alt={this.state.camellia.name}></img>
                        <CamelliaCategory description={this.state.camellia.species} category="Species/Combination" />
                        <CamelliaCategory description={this.state.camellia.scientificName} category="Scientific Name" />
                        <div className="bg-emerald-900/20 mt-8 rounded-full flex items-center justify-center py-4 text-emerald-900 cursor-pointer hover:scale-105" onClick={() => { this.loadMore() }}>
                            <BiImages></BiImages>
                            <p className="ml-2 text-center text-emerald-900">{this.state.moreLoaded ? "Less Photos" : "More Photos"}</p>
                        </div>
                        <AnimateHeight duration={500} height={this.state.height}>
                        {this.state.moreLoaded &&
                            <div className="grid justify-between grid-cols-2 mt-8">
                                {this.state.camellia.otherImages.map((image) => {
                                    return( 
                                    <div className="flex justify-center">
                                        <img className="h-40 object-cover" alt="" src={image}></img>
                                    </div>)
                                })}
                            </div>
                        }
                        </AnimateHeight>

                    </div>
                </div>

            </div>
        )
    }
}
