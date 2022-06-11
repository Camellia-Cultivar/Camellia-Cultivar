import React from "react";
import './index.css';

class QuizCard extends React.Component {

    render() {
        if (
            this.props.images.length >= 1) {
            const maxInd = Math.min(this.props.images.length, 4)

            let photoGrid;

            if (maxInd <= 1) {
                photoGrid =
                    <div
                        className={"flex flex-row items-stretch"}
                    >
                        <div
                            className={
                                "grow rounded-md cursor-pointer gap-1 last:text-lg xl:last:text-3xl text-xl last:font-semibold text-transparent bg-no-repeat bg-center bg-cover ring-4 ring-transparent hover:ring-teal-300 focus:ring-teal-300"}
                            style={{backgroundImage: `url(${this.props.images[0]})`}}
                            onClick={() => {this.props.showModal(this.props.images)}}
                        ></div>
                    </div>
            } else {
                let basisClass;

                // switch needed because dynamic construction of class names does not work
                switch (maxInd) {
                    case 4:
                        basisClass = "basis-3/4"
                        break
                    case 3:
                        basisClass = "basis-7/12"
                        break
                    default:
                        basisClass = "basis-1/2"
                }
                photoGrid =
                    <div className={"flex flex-row items-stretch gap-1"}>
                        <div
                            className={
                                (basisClass + " rounded-l-md") +
                                " cursor-pointer gap-1 last:text-lg xl:last:text-3xl text-xl last:font-semibold text-transparent bg-no-repeat bg-center bg-cover ring-4 ring-transparent hover:ring-teal-300 focus:ring-teal-300"}
                            style={{backgroundImage: `url(${this.props.images[0]})`}}
                            onClick={() => {this.props.showModal(this.props.images)}}
                        ></div>
                        <div className="grow grid grid-flow-row auto-rows-fr items-stretch justify-items-stretch gap-1">
                            {this.props.images.slice(1, maxInd).map((link, index, row) =>
                                <div
                                    key={this.props.id + "-image-" + index}
                                    className="relative cursor-pointer row-span-1 col-span-1
                                    first:rounded-tr-md last:rounded-br-md
                                    last:text-lg xl:last:text-3xl text-xl last:font-semibold text-transparent
                                    bg-no-repeat bg-center bg-cover
                                    ring-4 ring-transparent hover:ring-teal-300 focus:ring-teal-300"
                                    style={{backgroundImage: `url(${link})`}}
                                    onClick={() => {this.props.showModal(this.props.images, index + 1)}}
                                >{(index + 1 === row.length) && row.length < this.props.images.length - 1 && (
                                    <p>+{(this.props.images.length - index - 1)}</p>
                                )}</div>
                            )}
                        </div>
                    </div>;
            }

            return (
                    <div className={'quiz-card bg-emerald-900/10 snap-center pop-in'}
                         style={{animationDelay: `${this.props.delay}ms`}}>
                        {photoGrid}
                        <div className="justify-self-center relative mt-3.5 w-3/4 group">
                            <input id={"quizcard_input_" + this.props.id}
                                   className="block py-2 px-0 w-full text-sm text-gray-900 bg-transparent border-0 border-b-2 border-gray-300 appearance-none outline-none ring-0 focus:border-emerald-900 peer"
                                   placeholder=" " type="text"/>
                            <label
                                htmlFor={"quizcard_input_" + this.props.id}
                                className="cursor-text peer-focus:cursor-auto absolute text-sm text-gray-500 font-medium duration-300 scale-75 -translate-y-5 transform top-2.5 origin-[0] peer-focus:text-emerald-900 peer-placeholder-shown:scale-100 peer-placeholder-shown:translate-y-0 peer-focus:scale-75 peer-focus:-translate-y-5"
                            >Name the Cultivar
                            </label>
                        </div>
                    </div>
            );
        }

    }
}
export default QuizCard;