import { combineReducers } from "redux";
import loggedReducer from "./loggedReducer";
import userReducer from "./userReducer";
import modReducer from './modReducer'

const rootReducer = combineReducers({
    isLogged:loggedReducer,
    user:userReducer,
    isMod:modReducer,
})

export default rootReducer;