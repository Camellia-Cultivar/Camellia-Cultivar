const userReducer = (state = {}, action) => {
    switch (action.type) {
        case 'SIGNED_IN':
            return action.payload;
        case 'SIGNED_OUT':
            return {};
        default:
            return state;
    }
}

export default userReducer;