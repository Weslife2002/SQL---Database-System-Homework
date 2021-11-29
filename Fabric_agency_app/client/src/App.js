import styled from 'styled-components'
import {BrowserRouter as Router, Route, Redirect, Switch} from 'react-router-dom'
import {useState} from 'react'
import {useSelector} from 'react-redux'
import axios from 'axios'
import Login from "./pages/Login"
import Home from "./pages/Home"
import Add from "./pages/Add"


function ProtectedRoute({flag, children, ...props}){  
  return  <Route 
  render = {() => {
    if(!flag){
      return <Redirect to='/login'></Redirect>
    }
    else {
      return children;
    }
  }}
  />
}

function Register(){

  return (
    <h1>This is register page</h1>
  )
}

function App() {
  const isError = useSelector(state => state.user.error);

  return (
    <Router>
      <Switch>
        <Route path='/login' exact>
          <Login />
        </Route>
        <Route path='/register' exact>
          <Register />
        </Route>
        <ProtectedRoute path='/' flag={isError} exact>
          <Home />
        </ProtectedRoute>
        <ProtectedRoute path='/supplier/addNew' flag={isError} exact>
          <Add />
        </ProtectedRoute>
      </Switch>
    </Router>
  );
}

export default App;
