import React from 'react';
import StepList from "../../components/StepList";

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
            <div className="flex flex-row text-white bg-emerald-900">
                <div className="grow">
                    <h2 className="font-semibold leading-tight text-3xl"><span className="font-bold">Help identify</span> specimens</h2>
                    <ol className="list-decimal">
                        <li>AAA</li>
                        <li>BBB</li>
                    </ol>
                    <StepList steps={first_list}/>
                </div>
                <div className="flex-none bg-stone-100 rounded-l-full">
                    aaaaaaaaaa
                </div>
            </div>
            <StepList steps={second_list}/>
        </div>
    );
}
export default Home;