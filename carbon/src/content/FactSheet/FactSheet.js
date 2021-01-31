import React from 'react';
import {
  Breadcrumb,
  BreadcrumbItem,
  Button,
  UnorderedList,
  Tabs,
  Tab,
  ListItem,
} from 'carbon-components-react';
import { InfoSection, InfoCard } from '../../components/Info';
import Globe32 from '@carbon/icons-react/lib/globe/32';
import PersonFavorite32 from '@carbon/icons-react/lib/person--favorite/32';
import Application32 from '@carbon/icons-react/lib/application/32';
import { ETBListener, Instances, Expected, NotExpected, ClaimOk, ClaimFail, jsonOfConstant, getFirstCN, getOU } from '../../evidentia';
import { StatusSection } from './StatusSection';
import { DataSection } from './DataSection';
import { ConfigurationSection } from './ConfigurationSection';
import { ParticipantsSection } from './ParticipantsSection';
import { RawClaims } from './RawClaims';

const props = {
  tabs: {
    selected: 0,
    // triggerHref: '#',
    role: 'navigation',
  },
  tab: {
    // href: '#',
    role: 'presentation',
    tabIndex: 0,
  },
};


class FactSheet extends ETBListener {
  render() {
    return (
      <div className="bx--grid bx--grid--full-width fact-sheet">
        <div className="bx--row fact-sheet__banner">
          <div className="bx--col-lg-16">
            <Breadcrumb noTrailingSlash aria-label="Page navigation">
              <BreadcrumbItem>
                <a href="/">Home</a>
              </BreadcrumbItem>
            </Breadcrumb>
            <h1 className="fact-sheet__heading">
              Citizen Participation Factsheet
          </h1> 
          </div>
        </div>
        <div className="bx--row fact-sheet__r2">
          <div className="bx--col bx--no-gutter">
            <Tabs {...props.tabs} aria-label="Tab navigation">
              <Tab {...props.tab} label="Text">
                <div className="bx--grid bx--grid--no-gutter bx--grid--full-width">
                  <div className="bx--row fact-sheet__tab-content">
                    <div className="bx--col-sm-0 bx--col-md-2 bx--col-lg-3 fact-sheet__toc">
                      <div className="bx--row">
                        <Button kind='ghost' href="#overview">Overview</Button>
                      </div>
                      <div className="bx--row">
                        <Button kind='ghost' href="#purpose">Purpose</Button>
                      </div>
                      <div className="bx--row">
                        <Button kind='ghost' href="#status">Status</Button>
                      </div>
                      <div className="bx--row">
                        <Button kind='ghost' href="#participants">Participants</Button>
                      </div>
                      <div className="bx--row">
                        <Button kind='ghost' href="#data">Data</Button>
                      </div>
                      <div className="bx--row">
                        <Button kind='ghost' href="#configuration">Configuration</Button>
                      </div>
                      <div className="bx--row">
                        <Button kind='ghost' href="#modelinformation">Model Information</Button>
                      </div>
                    </div>
                    <div className="bx--col-md-6 bx--col-lg-9">
                      <h2 id="overview" className="fact-sheet__subheading">
                        Overview
                    </h2>
                      <p className="fact-sheet__p">
                        This document is a FactSheet accompanying the citizen
                        participation model produced in a federated manner by
                        several German cities.
                        FactSheets aim at increasing trust in AI services by
                        documenting the learning process transparently.
                      </p>

                      <h2 id="purpose" className="fact-sheet__subheading">
                        Purpose
                      </h2>
                      <p className="fact-sheet__p">
                        The model documented in this FactSheet is the basis of an application that
                        allows citizens to submit improvement suggestions for plans
                        by the municipal administration. The administration wants to use machine learning
                        to classify and analyse suggestions, so that they can be processed more effectively.
                        Having been successfully tested in one city, a number of cities decide to roll out
                        the system too. It would now be desirable to analyse the combined data to produce
                        higher quality models for classifying suggestions. However, due to the federal
                        organization of the German state, particularly with respect to data privacy,
                        the cities may not be able to share their data directly.
                        The produce a model using federated machine learning.
                      </p>

                      <StatusSection db={this.state}/>

                      {/* <h2 id="participants" className="fact-sheet__subheading">
                        Participants
                      </h2>

                      <p className="fact-sheet__p">                        
                      The following parties have participated in the learning process:
                      </p>
                      <Expected db={this.state} symbol="configuration"
                        found={claims => <UnorderedList>
                          {claims.map(claim => 
                          <ListItem key={JSON.stringify(claim)}>{getOU(claim.principal.subject)}<ClaimOk claim={claim} /></ListItem>)
                          }
                        </UnorderedList>} />
 */}
                      <ParticipantsSection db={this.state}/>

                      <ConfigurationSection db={this.state}/>

                      <DataSection db={this.state}/>



                      <h2 id="modelinformation" className="fact-sheet__subheading">
                        Model Information
                      </h2>

                      <p className="fact-sheet__p">
                      </p>

                        <Instances db={this.state} symbol="configuration"
                          empty={<>Information about the configuration of participants is (still) missing.<ClaimFail /></>}>
                        {claims =>
                            claims.map(claim => {
                              let config = jsonOfConstant(claim.args[0]);
                              return <React.Fragment key={JSON.stringify(claim)}>
                                <h3 className="fact-sheet__subsubheading">
                                  Model details of {getFirstCN(claim.principal.subject)}
                                  <ClaimOk claim={claim} />
                                </h3>

                                <UnorderedList>
                                  <ListItem> Model name: <tt>{config.model.spec.model_name}</tt> </ListItem>
                                  <ListItem> Model definition: <tt>{config.model.spec.model_definition}</tt> </ListItem>
                                  <ListItem> Class reference: <tt>{config.model.cls_ref}</tt> </ListItem>
                                </UnorderedList>
                              </React.Fragment>
                            })}
                        </Instances>
                    </div>
                    <div className="bx--col-md-0 bx--col-md-0 bx--offset-lg-1 bx--col-lg-3 ">
                      <img
                        className="fact-sheet__illo"
                        src={"https://aifs360.mybluemix.net/fslogo.png"}
                        //                        src={`${process.env.PUBLIC_URL}/tab-illo.png`}
                        alt="Carbon illustration"
                      />
                    </div>
                  </div>
                </div>
              </Tab>
              {/* <Tab {...props.tab} label="Tabular">
                <div className="bx--grid bx--grid--no-gutter bx--grid--full-width">
                  <div className="bx--row fact-sheet__tab-content">
                    <div className="bx--col-lg-16">
                      Rapidly build beautiful and accessible experiences. The
                      Carbon kit contains all resources you need to get started.
                  </div>
                  </div>
                </div>
              </Tab> */}
              <Tab {...props.tab} label="Full Details">
                <div className="bx--grid bx--grid--no-gutter bx--grid--full-width">
                  <div className="bx--row fact-sheet__tab-content">
                    <div className="bx--col-lg-16">

                      <h2 className="fact-sheet__subheading">All recorded facts</h2>

                      <p className="fact-sheet__p">
                        The following list shows all the facts that were recorded
                        during the training process.
                      </p>
                      <RawClaims db={this.state} />
                    </div>
                  </div>
                </div>
              </Tab>
            </Tabs>            
          </div>
        </div>
        <InfoSection heading="The Principles" className="fact-sheet__r3">
          <InfoCard
            heading="Carbon is Open"
            body="It's a distributed effort, guided by the principles of the open-source movement. Carbon's users are also it's makers, and everyone is encouraged to contribute."
            icon={<PersonFavorite32 />}
          />
          <InfoCard
            heading="Carbon is Modular"
            body="Carbon's modularity ensures maximum flexibility in execution. It's components are designed to work seamlessly with each other, in whichever combination suits the needs of the user."
            icon={<Application32 />}
          />
          <InfoCard
            heading="Carbon is Consistent"
            body="Based on the comprehensive IBM Design Language, every element and component of Carbon was designed from the ground up to work elegantly together to ensure consistent, cohesive user experiences."
            icon={<Globe32 />}
          />
        </InfoSection>
      </div>
    );
  }
}

export default FactSheet
