import React, { useState } from 'react'
import axios from 'axios'
import {Link} from 'react-router-dom'
import { useDispatch, useSelector } from "react-redux";
import {loginStart, loginSuccess, loginFailure, logout} from '../slices/userSlice'
import '../Content/home.css'
import { useHistory } from 'react-router-dom';

function Home() {
    const history = useHistory();
    const [purchase, setPurchase] = useState(null);
    const [categories, setCategories] = useState(null);
    const [search, setSearch] = useState("");
    const [choice, setChoice] = useState(0);
    const dispatch = useDispatch();

    const handleClick = async () => {
        console.log("click")
        
        if(choice == 0)
        {
            const result = await axios.get('http://localhost:3071/api/manager/supplier?id=' + search);

            if(result.data != null)
            {
                console.log(result.data)
                setPurchase(result.data)
            }
        }
        else
        {
            const result = await axios.get('http://localhost:3071/api/manager/supplier/categories?id=' + search);

            if(result.data.length > 0)
            {
                console.log(result.data)
                console.log(new Date(result.data[0].supply_date.toLocaleString()))
                var newObject = result.data.map(c =>{ 
                    return {supply_date: c.supply_date.toLocaleString(), ...c}
                })
                console.log(newObject)
                setCategories(newObject)
            }
        }
        
    }

    const logOut = () => {
        dispatch(logout());
        history.push('/login');
    }

    return (
        <div className="s003">
            <form>
                <div className="inner-form">
                <div className="input-field first-wrap">
                    <div className="input-select">
                        <select onChange={(e) => {setChoice(e.target.value)}}>
                            <option value={0}>Category</option>
                            <option value={1}>Supplier</option>
                        </select>
                    </div>
                </div>
                <div className="input-field second-wrap">
                    <input id="search" type="text" onChange={(e) => setSearch(e.target.value)} placeholder="Enter Keywords?" />
                </div>
                <div className="input-field third-wrap">
                    <button className="btn-search" type="button" onClick={handleClick}>
                    <svg className="svg-inline--fa fa-search fa-w-16" aria-hidden="true" data-prefix="fas" data-icon="search" role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 512 512">
                        <path fill="currentColor" d="M505 442.7L405.3 343c-4.5-4.5-10.6-7-17-7H372c27.6-35.3 44-79.7 44-128C416 93.1 322.9 0 208 0S0 93.1 0 208s93.1 208 208 208c48.3 0 92.7-16.4 128-44v16.3c0 6.4 2.5 12.5 7 17l99.7 99.7c9.4 9.4 24.6 9.4 33.9 0l28.3-28.3c9.4-9.4 9.4-24.6.1-34zM208 336c-70.7 0-128-57.2-128-128 0-70.7 57.2-128 128-128 70.7 0 128 57.2 128 128 0 70.7-57.2 128-128 128z"></path>
                    </svg>
                    </button>
                </div>
                </div>
            </form>
            <div style={{width: '750px'}}>
                <Link style={{color: 'white',float: 'right', marginTop: '10px'}}  to='/supplier/addNew'>Add new?</Link>
                <Link style={{color: 'white',float: 'right', marginTop: '10px', marginRight: '10px'}} onClick={logOut} to='#'>Logout</Link>
            </div>
            
            {   
                (choice == 0) && purchase && ( 
                        <table className="table">
                            <thead>
                                <tr>
                                    <th scope="col">ManagerCode</th>
                                    <th scope="col">SupplierCode</th>
                                    <th scope="col">SupplierName</th>
                                    <th scope="col">SupplierBankAccount</th>
                                    <th scope="col">SupplierAddress</th>
                                    <th scope="col">SupplierTaxCode</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    {
                                        Object.values(purchase).map((e, index) => (
                                            <td key={index}>{e}</td>
                                        ))
                                    }
                                </tr>
                            </tbody>
                        </table>
                )
            }
            {
                (choice == 1) && categories && ( 
                    <table className="table">
                        <thead>
                            <tr>
                                <th scope="col">CategoryCode</th>
                                <th scope="col">CategoryName</th>
                                <th scope="col">Quantity</th>
                                <th scope="col">SupplierCode</th>
                                <th scope="col">SupplyQuantity</th>
                                <th scope="col">SupplyDate</th>
                                <th scope="col">SupplyPrice</th>
                            </tr>
                        </thead>
                        <tbody>
                            {
                                categories.map((e, idx) => (
                                    <tr key={idx}>
                                        {
                                            Object.values(e).map((c, index) => (
                                                <td key={index}>{c}</td>
                                            )) 
                                        }
                                    </tr>
                                ))
                            }
                        </tbody>
                    </table>
            )
            }
        </div>
    )
}

export default Home
