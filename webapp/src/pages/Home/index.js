import React from 'react';
import StepList from "../../components/StepList";


// static data (to remove when backend is functional)
let first_list = [
    {"id": 1, "content": "Access the Quizzes page"},
    {"id": 2, "content": "Choose one of the specimen from the questionnaire"},
    {"id": 3, "content": "Fill in the species/cultivar the specimen belongs to"},
    {"id": 4, "content": "Complete the quizz and submit"}
];

let second_list = [
    {"id": 1, "content": "Take as many pictures of it as you can"},
    {"id": 2, "content": "Fill in some details and characteristics"},
    {"id": 3, "content": "Submit!"},
];

const Home = () =>{
    return (
        <div className="bg-stone-100">
            <div className="grid gap-3 sm:place-items-center grid-flow-row-dense md:place-items-end sm:grid-cols-1 md:grid-cols-5 bg-emerald-900 text-white py-16">
                <div className="grid col-span-3 mx-8">
                    <span className="font-semibold leading-tight text-4xl"><span className="font-bold">Help identify</span> specimens</span>
                    <span className="text-lg mt-5 ml-7">Fill in quizzes about what cultivar is a specimen and earn reputation points!</span>
                    <div className="ml-11"><StepList steps={first_list}/></div>
                </div>
                <div className="col-span-2 justify-self-stretch self-stretch bg-stone-100 rounded-l-full"></div>
            </div>


            <div className="grid gap-3 sm:place-items-center grid-flow-row-dense md:place-items-start sm:grid-cols-1 md:grid-cols-5 text-neutral-900 py-16">
                <div className="col-span-2 justify-self-stretch self-stretch bg-stone-100 rounded-r-full bg-emerald-900"></div>
                <div className="grid col-span-3 mx-8">
                    <span className="font-semibold leading-tight text-4xl"><span className="font-bold">Get an Identification</span> for your specimen</span>
                    <span className="text-lg mt-5 ml-7">Found a specimen and can't identify it? You can upload it to our system and other users will help you!</span>
                    <div className="ml-11"><StepList steps={second_list}/></div>
                </div>
            </div>
        </div>
    );
}
export default Home;