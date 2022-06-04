import React from 'react';
import QuizCard from "../../components/QuizCard";
import StepList from "../../components/StepList";
import PhotoGridModal from "../../components/PhotoGridModal";


let scrl = React.createRef();

// slide scroll to neighbor child
//  direction = -1
//  direction =  1
const slide = (direction = 1) => {
    scrl.current.scrollLeft += direction * scrl.current.scrollWidth / scrl.current.children.length;
};

class Quizzes extends React.Component {
    constructor(props) {
        super(props);
        this.state = {
            modalVisible: false,
            modalImagesArray: [],
            modalImageIndex: 0
        };

        this.showModalWithContent = this.showModalWithContent.bind(this)
        this.setModalImageIndex = this.setModalImageIndex.bind(this)
        this.hideModal = this.hideModal.bind(this);
    }

    setModalImageIndex(index) {
        this.setState({modalImageIndex: index})
    }

    showModalWithContent(set, index=0) {
        this.setModalImageIndex(index)
        this.setState({modalImagesArray: set})
        this.setState({ modalVisible: true })
    }

    hideModal() {
        this.setState({ modalVisible: false });
    }

    render() {

        return (
            <div className="select-none">
                <PhotoGridModal
                    photosArray={this.state.modalImagesArray}
                    currentPhotoIndex={this.state.modalImageIndex}
                    setModalImageIndex={this.setModalImageIndex}
                    modalVisible={this.state.modalVisible}
                    hideModal={this.hideModal}
                />
                <div className=
                         "grid gap-3 grid-flow-row-dense
                     sm:place-items-center sm:grid-cols-1
                     md:place-items-start md:grid-cols-5
                     py-10
                     text-neutral-900"
                >
                    <div className=
                             "col-span-2 justify-self-stretch self-stretch rounded-r-full bg-emerald-500/20 slider"
                    ></div>
                    <div className="grid col-span-3 mx-5">
                        <span className="leading-tight text-4xl font-bold fade-in" style={{animationDelay:`1000ms`}}>Quizzes</span>
                        <span className="md:text-lg mt-5 md:ml-3 fade-in" style={{animationDelay:`1100ms`}}>The more quizzes you answer correctly, the higher your reputation will get!</span>
                        <div className="md:ml-3"><StepList baseDelay={1100} steps={steps}/></div>
                    </div>
                    <div className="col-span-2 justify-self-stretch self-stretch bg-stone-100 rounded-l-full"></div>
                </div>
                <div ref={scrl}
                     className=
                         "relative flex w-full
                     pb-4 md:gap-4
                     scroll-smooth snap-x snap-mandatory overflow-x-scroll
                     lg:overflow-x-auto lg:flex-none lg:grid lg:grid-cols-3 lg:grid-rows-2 lg:mx-auto lg:max-w-screen-md lg:gap-x-8 lg:gap-y-3.5 lg:px-0
                     xl:max-w-screen-lg fade-in" style={{animationDelay:`1400ms`}}
                >
                    {/* "<" Button */}
                    <div className="z-50 lg:hidden flex items-center sticky left-0 bg-gradient-to-r from-neutral-900/5 md:px-4">
                        <div className="bg-teal-400 rounded-full p-3.5 mx-2 ring-0 hover:ring ring-teal-200" onClick={() => slide(-1)}>
                            <svg xmlns="http://www.w3.org/2000/svg" className="h-7 w-7  md:h-12 md:w-12 stroke-white stroke-2 fill-transparent" viewBox="0 0 24 24">
                                <path strokeLinecap="round" strokeLinejoin="round" d="M15 19l-7-7 7-7" />
                            </svg>
                        </div>
                    </div>
                    {quizzes.map(
                        (quiz, index) =>
                            <QuizCard
                                key={"quiz_card_" + index}
                                delay={1400 + index * 100}
                                id={ quiz.id }
                                images={ quiz.images }
                                showModal={this.showModalWithContent}
                            />
                    )}

                    <div className="lg:hidden flex items-center sticky right-0 bg-gradient-to-l from-neutral-900/5 md:px-4">
                        {/* ">" Button */}
                        <div className="z-50 bg-teal-400 rounded-full p-3.5 mx-2 ring-0 hover:ring ring-teal-200" onClick={() => slide()}>
                            <svg xmlns="http://www.w3.org/2000/svg" className="h-7 w-7 md:h-12 md:w-12 stroke-white stroke-2 fill-transparent" viewBox="0 0 24 24">
                                <path strokeLinecap="round" strokeLinejoin="round" d="M9 5l7 7-7 7" />
                            </svg>
                        </div>
                    </div>
                </div>
                <div className="grid items-center pt-5 pb-10 static">
                    <button type="submit" className="mx-auto bg-emerald-900 text-white hover:ring-2 ring-offset-1 ring-teal-500 rounded-lg px-7 py-2 font-semibold fade-in z-0" style={{animationDelay:`1400ms`}}>Submit</button>
                </div>
            </div>
        );
    }


}

export default Quizzes;

// static data (remove when API is connected)

let steps = [
    { "id": 1, "content": 'The quizz will have 6 specimens to identify' },
    { "id": 2, "content": 'You can identify each specimen by inserting the name of it\'s species/cultivar' },
    { "id": 3, "content": 'Submit your answers even if you can not identify all the specimens!' }
];

let quizzes = [
    {
        "id": 1305,
        "images": [
            '/camellia1.jpg',
            '/camellia2.jpg',
            '/camellia3.jpg',
            '/camellia4.jpg',
            '/camellia5.jpg',
            '/camellia6.jpg',
            '/camellia7.jpg',
            '/camellia8.jpg',
            '/camellia9.jpg',
        ]
    },
    {
        "id": 1306,
        "images": [
            'https://images.unsplash.com/photo-1554629947-334ff61d85dc?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1024&h=1280&q=80',
            'https://images.unsplash.com/photo-1554629947-334ff61d85dc?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1024&h=1280&q=80',
            'https://images.unsplash.com/photo-1554629947-334ff61d85dc?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1024&h=1280&q=80',
        ]
    },
    {
        "id": 1307,
        "images": [
            'https://images.unsplash.com/photo-1554629947-334ff61d85dc?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1024&h=1280&q=80',
            'https://images.unsplash.com/photo-1554629947-334ff61d85dc?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1024&h=1280&q=80',
        ]
    },
    {
        "id": 1308,
        "images": [
            'https://images.unsplash.com/photo-1554629947-334ff61d85dc?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1024&h=1280&q=80',
            'https://images.unsplash.com/photo-1554629947-334ff61d85dc?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1024&h=1280&q=80',
            'https://images.unsplash.com/photo-1554629947-334ff61d85dc?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1024&h=1280&q=80',
            'https://images.unsplash.com/photo-1554629947-334ff61d85dc?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1024&h=1280&q=80',
            'https://images.unsplash.com/photo-1554629947-334ff61d85dc?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1024&h=1280&q=80',
        ]
    },
    {
        "id": 1310,
        "images": [
            'https://images.unsplash.com/photo-1554629947-334ff61d85dc?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1024&h=1280&q=80',
            'https://images.unsplash.com/photo-1554629947-334ff61d85dc?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1024&h=1280&q=80',
            'https://images.unsplash.com/photo-1554629947-334ff61d85dc?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1024&h=1280&q=80',
            'https://images.unsplash.com/photo-1554629947-334ff61d85dc?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1024&h=1280&q=80',
        ]
    },
    {
        "id": 1311,
        "images": [
            'https://images.unsplash.com/photo-1554629947-334ff61d85dc?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1024&h=1280&q=80'
        ]
    }
]