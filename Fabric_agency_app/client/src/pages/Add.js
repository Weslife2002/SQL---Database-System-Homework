import styled from 'styled-components'
import {BrowserRouter as Router, Route, Link, Redirect, Switch} from 'react-router-dom'
import {useState} from 'react'
import {useSelector} from 'react-redux'
import axios from 'axios'

const Container = styled.div`
    display: flex;
    width: 1200px;
    justify-content: space-between;

`
const Button = styled(Link)`
    font-weight: 600;
    font-size: 16px;
    padding: 10px;
    background: white;
    cursor: pointer;

    &:hover {
        background: gray;
        color: white;
    }
;
`

const Button2  = styled(Button)`
    background: #63c76a;
    color: white;
    &:hover {
        background: lightgreen;
    }
`

function Add() {

    const [partnerStaffCode, setPartnerStaffCode] = useState("");
    const [supCode, setSupCode] = useState(""); 
    const [supName, setSupName] = useState(""); 
    const [supBankAcc, setSupBankAcc] = useState(""); 
    const [supAdd, setSupAdd] = useState(""); 
    const [supTaxCode, setSupTaxCCode] = useState("");

    const handleSubmit = async () => {
        var request = {
            supplier_code: supCode,
            supplier_name: supName,
            supplier_bank_account: supBankAcc,
            supplier_address: supAdd,
            supplier_tax_code: supTaxCode,
            partner_staff_code: partnerStaffCode
        }

        var result = await axios.post('http://localhost:3071/api/manager/supplier', request)

        console.log(result);
    }
    return (
    <div className="s003">
        <Container>
            <Button to='/'>Return to list</Button>
            <Button2 onClick={handleSubmit} to="#">Add new supplier</Button2>
        </Container>

                        <table className="table">
                            <thead>
                                <tr>
                                    <th scope="col">SupplierCode</th>
                                    <th scope="col">SupplierName</th>
                                    <th scope="col">SupplierBankAccount</th>
                                    <th scope="col">SupplierAddress</th>
                                    <th scope="col">SupplierTaxCode</th>
                                    <th scope="col">PartnerStaffCode</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td><input type="text" onChange={(e) => setSupCode(e.target.value)}></input></td>
                                    <td><input type="text" onChange={(e) => setSupName(e.target.value)}></input></td>
                                    <td><input type="text" onChange={(e) => setSupBankAcc(e.target.value)}></input></td>
                                    <td><input type="text" onChange={(e) => setSupAdd(e.target.value)}></input></td>
                                    <td><input type="text" onChange={(e) => setSupTaxCCode(e.target.value)}></input></td>
                                    <td><input type="text" onChange={(e) => setPartnerStaffCode(e.target.value)}></input></td>
                                </tr>
                            </tbody>
                        </table>
    </div>
  );
}

export default Add;
