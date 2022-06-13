const modReducer = (state = false, action) => {
    switch (action.type) {
        case 'IS_MOD':
            return true;
        case 'IS_NOT_MOD':
            return false;
        default:
            return state;
    }
}

export default modReducer;