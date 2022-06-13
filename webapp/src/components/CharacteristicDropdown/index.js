import React, { Component } from 'react';
import AnimateHeight from 'react-animate-height';

import { IoChevronDown } from "react-icons/io5";
import { IoChevronUp } from "react-icons/io5";


class CharacteristicDropdown extends Component {
    constructor(props) {
        super(props);
        this.state = {
            down: this.props.down,
            height:0,
            details: this.props.details

        }
    }

    renderDetails = () => { 
        const {height} = this.state;
        height==='auto' ? setTimeout(() =>{this.setState({down:!this.state.down})}, 305) : this.setState({down:!this.state.down});
        this.setState({
            height: height===0 ? 'auto':0
        })
        
    }


    render() {
        return (
            <div className="ml-3 my-3" onClick={() => { this.renderDetails(); }}>
                <div className="flex justify-between items-center pr-2 border-b-2 text-emerald-900 cursor-pointer hover:border-b-emerald-900">
                    <p className="text-xl mt-2 mb-1">{this.props.characteristic}</p>
                    {this.state.down ? <IoChevronUp></IoChevronUp> : <IoChevronDown></IoChevronDown>}
                </div>
                <AnimateHeight duration={500} height={this.state.height}>
                    <div className="px-6 bg-emerald-900/10 shadow-inner">
                        { this.state.down &&
                                    <div className="flex w-full justify-between py-2">
                                        <p className=" text-sm sm:text-base capitalize font-semibold text-left mr-1 sm:w-1/2">{this.props.details.characteristic}</p>
                                        <p className=" text-sm sm:text-base capitalize text-right ml-1 sm:w-1/2">{this.props.details.value}</p>
                                    </div>
                        }
                    </div>
                </AnimateHeight>

            </div>
        );
    }
}

export default CharacteristicDropdown;