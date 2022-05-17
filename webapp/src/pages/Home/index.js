import React, { useRef } from 'react';
import StepList from "../../components/StepList";
import useIntersection from '../../utilities/useIntersection';


// static data (to remove when backend is functional)
let first_list = [
    { "id": 1, "content": "Access the Quizzes page" },
    { "id": 2, "content": "Choose one of the specimen from the questionnaire" },
    { "id": 3, "content": "Fill in the species/cultivar the specimen belongs to" },
    { "id": 4, "content": "Complete the quizz and submit" }
];

let second_list = [
    { "id": 1, "content": "Take as many pictures of it as you can" },
    { "id": 2, "content": "Fill in some details and characteristics" },
    { "id": 3, "content": "Submit!" },
];




const Home = () => {

    return (
        <div className="bg-stone-100 pb-16">

            {/* "Help identify" section */}
            <div className="grid gap-3 sm:place-items-center grid-flow-row-dense md:place-items-end sm:grid-cols-1 md:grid-cols-5 bg-emerald-900 text-white py-16">
                <div className="grid col-span-3 mx-8">
                    <span className="font-semibold leading-tight text-4xl fade-in-1"><span className="font-bold">Help identify</span> specimens</span>
                    <span className="text-lg mt-5 ml-7 fade-in-2">Fill in quizzes about what cultivar is a specimen and earn reputation points!</span>
                    <div className="ml-11"><StepList steps={first_list} /></div>
                </div>
                <div className="col-span-2 justify-self-stretch self-stretch bg-stone-100 slider-inverted rounded-l-full"></div>
            </div>

            {/* "Get an Identification" section */}
            <div className="grid gap-3 sm:place-items-center grid-flow-row-dense md:place-items-start sm:grid-cols-1 md:grid-cols-5 text-neutral-900 py-16">
                <div className="col-span-2 justify-self-stretch self-stretch rounded-r-full bg-emerald-900 slider"></div>
                <div className="grid col-span-3 mx-8">
                    <span className="font-semibold leading-tight text-4xl fade-in-1"><span className="font-bold">Get an Identification</span> for your specimen</span>
                    <span className="text-lg mt-5 ml-7 fade-in-2">Found a specimen and can't identify it? You can upload it to our system and other users will help you!</span>
                    <div className="ml-11"><StepList steps={second_list} /></div>
                </div>
            </div>

            <div className="flex justify-center text-center">
                <div className="grid grid-cols-2 md:grid-cols-3 gap-6 bg-emerald-900/5 text-emerald-900 p-10 rounded-lg fade-in-1">

                    <span className="col-span-2 md:col-span-3 font-semibold text-3xl fade-in-2">What we have <span className="font-bold">achieved</span></span>

                    <div className="flex flex-col justify-center border-4 rounded-lg border-emerald-900 p-4 aspect-[4/3] item-fade-in-1">
                        <span className="text-3xl font-bold">10000+</span>
                        <span className="text-xl font-normal">Specimens identified</span>
                    </div>
                    <div className="flex flex-col justify-center border-4 rounded-lg border-emerald-900 p-4 aspect-[4/3] item-fade-in-2">
                        <span className="text-3xl font-bold">3000+</span>
                        <span className="text-xl font-normal">Registered Users</span>
                    </div>
                    <div className="flex flex-col justify-center border-4 rounded-lg border-emerald-900 p-4 aspect-[4/3] item-fade-in-3">
                        <span className="text-3xl font-bold">3000+</span>
                        <div className="flex-shrink text-xl font-normal">Specimen photos uploaded</div>
                    </div>
                </div>
            </div>
        </div>


    );
}

export default Home;