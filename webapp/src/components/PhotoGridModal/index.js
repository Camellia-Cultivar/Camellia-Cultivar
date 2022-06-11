import React from "react";
import {TransformComponent, TransformWrapper} from "react-zoom-pan-pinch";

class PhotoGridModal extends React.Component {
    render() {
        return (
            <div className={`fixed z-50 inset-0 overflow-y-auto bg-stone-900/90 ${!this.props.modalVisible ? "hidden" : ""}`}
                 onClick={this.props.hideModal}
            >
                <div className="flex flex-col items-end sm:items-center justify-center min-h-full p-4 text-white text-center text-lg sm:p-0">
                    <div className="relative container bg-white rounded-lg text-left overflow-hidden shadow-xl transform transition-all sm:my-8">
                        <div className="grid grid-cols-6 justify-items-stretch px-4 pt-5 sm:p-6 h-[75vh]"
                             onClick={(e) => e.stopPropagation()}
                        >
                            <div>
                                {this.props.photosArray.map((link, index, row) =>
                                    <div
                                        key={this.props.id + "-image-" + index}
                                        className=
                                            "relative cursor-pointer last:text-lg xl:last:text-3xl text-xl last:font-semibold text-transparent bg-no-repeat bg-center bg-cover h-12 w-12 ring-4 ring-transparent hover:ring-teal-300 focus:ring-teal-300"
                                        style={{backgroundImage: `url(${link})`}}
                                        onClick={() => this.props.setModalImageIndex(index)}
                                    >
                                        {(index + 1 === row.length) && row.length < this.props.photosArray.length - 1 && (
                                        <p>+{(this.props.photosArray.length - index)}</p>
                                    )}</div>
                                )}
                            </div>
                            <div className="relative col-span-5 bg-contain bg-no-repeat bg-center"
                            >

                                <TransformWrapper
                                    minScale={0.1}
                                    maxScale={20}
                                    centerOnInit={true}
                                    wheel={{step: 0.5}}
                                >
                                    <TransformComponent
                                        wrapperStyle={{ width: "100%", height: "100%", backgroundColor: "rgb(6 78 59 / 0.1)"}}
                                    >
                                        <img
                                            style={{height: "calc(75vh - 3rem)"}}
                                            src={`${this.props.photosArray[this.props.currentPhotoIndex]}`}
                                            alt="Enlarged Version"
                                        />
                                    </TransformComponent>
                                </TransformWrapper>
                            </div>
                        </div>
                    </div>
                    Click anywhere to close
                </div>
            </div>
        );
    }
}

export default PhotoGridModal;