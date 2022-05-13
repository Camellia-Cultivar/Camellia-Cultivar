import React, { Component } from 'react';

class CamelliaCategory extends Component {
    render() {
        return (
            <div className="mt-8 flex bg-emerald-900/20 rounded-full">
                <div className="bg-emerald-900 flex justify-center items-center rounded-full w-1/2">
                    <p className="text-white py-4 px-8 text-center items-center">{this.props.category}</p>
                </div>
                <p className="text-emerald-900 p-2 m-auto text-center align-middle w-1/2">{this.props.description}</p>
            </div>
        );
    }
}

export default CamelliaCategory;