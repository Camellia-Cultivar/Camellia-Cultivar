import { combineReducers } from "redux";
import loggedReducer from "./isLogged";
import userReducer from "./user";
import modReducer from './modReducer'

const rootReducer = combineReducers({
    isLogged:loggedReducer,
    user:userReducer,
    isMod:modReducer,
})

export default rootReducer;