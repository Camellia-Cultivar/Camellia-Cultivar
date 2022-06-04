import React from 'react';
import { createRoot } from 'react-dom/client';
import { configureStore } from '@reduxjs/toolkit'

import './index.css';
import App from './App';
import CustomRouter from './components/CustomRouter';
import reportWebVitals from './reportWebVitals';
import history from './utilities/history'
import rootReducer from './redux/reducers'
import { Provider } from 'react-redux';
// import { BrowserRouter } from 'react-router-dom';

const container = document.getElementById('app');
const root = createRoot(container);

const store = configureStore({
    reducer: rootReducer
})


root.render(
    <Provider store={store}>
        <CustomRouter history={history}>
            <App />
        </CustomRouter>
    </Provider>
);

// If you want to start measuring performance in your app, pass a function
// to log results (for example: reportWebVitals(console.log))
// or send to an analytics endpoint. Learn more: https://bit.ly/CRA-vitals
reportWebVitals();
