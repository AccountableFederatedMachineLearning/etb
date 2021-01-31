import React, { Component } from 'react';
import './app.scss';
import { Content } from 'carbon-components-react/lib/components/UIShell';
import FactSheet from './content/FactSheet';

class App extends Component {
  render() {
    return (
      <>
        <Content>                   
          <FactSheet/>
          {/* <Switch>
            <Route path="/" component={LandingPage} />
            <Route path="/repos" component={RepoPage} />
          </Switch> */}
        </Content>
      </>
    );
  }
}

export default App;
