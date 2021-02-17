import React from 'react';
import {
  Breadcrumb,
  BreadcrumbItem,
  Button,
  Tabs,
  Tab,
} from 'carbon-components-react';
import { InfoSection, InfoCard } from '../../components/Info';
import Globe32 from '@carbon/icons-react/lib/globe/32';
import PersonFavorite32 from '@carbon/icons-react/lib/person--favorite/32';
import Application32 from '@carbon/icons-react/lib/application/32';
import { ETBListener } from '../../evidentia';
import { StatusSection } from './StatusSection';
import { DataSection } from './DataSection';
import { ModelSection } from './ModelSection';
import { ConfigurationSection } from './ConfigurationSection';
import { ParticipantsSection } from './ParticipantsSection';
import { MusketeerSection } from './MusketeerSection';
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
                        <Button kind='ghost' href="#accountability">Accountability</Button>
                      </div>
                      <div className="bx--row">
                        <Button kind='ghost' href="#status">Status</Button>
                      </div>
                      <div className="bx--row">
                        <Button kind='ghost' href="#participants">Participants</Button>
                      </div>
                      <div className="bx--row">
                        <Button kind='ghost' href="#configuration">Configuration</Button>
                      </div>
                      <div className="bx--row">
                        <Button kind='ghost' href="#data">Data</Button>
                      </div>
                      <div className="bx--row">
                        <Button kind='ghost' href="#modelinformation">Model Information</Button>
                      </div>
                      <div className="bx--row">
                        <Button kind='ghost' href="#musketeer">MUSKETEER Infrastructure</Button>
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

                      <h2 id="accountabilty" className="fact-sheet__subheading">
                        Accountability
                      </h2>

                      <p className="fact-sheet__p">
                        The data in factsheet documents a learning process performed with the
                        IBM Federated Machine Learning Framework. It was generated by the Evidentia
                        plugin, which keeps a tamper-proof record of the learning process. Evidentia
                        gives the participants and infrastructure component the ability to make claims
                        about the execution of the learning process. It continuously executes verification
                        workflows that verify the claims of all parties for consistency. This increases
                        the trust that all participants have adhered to the rules, as it rules out
                        manipulations that would lead to inconsistent statements. The tamper-proof record
                        may be used to reproduce the learning process.
                      </p>

                      <StatusSection db={this.state} />

                      <ParticipantsSection db={this.state} />

                      <ConfigurationSection db={this.state} />

                      <DataSection db={this.state} />

                      <ModelSection db={this.state} />

                      <MusketeerSection db={this.state} />

                    </div>
                    <div className="bx--col-md-0 bx--col-md-0 bx--offset-lg-1 bx--col-lg-3 ">
                      <img
                        className="fact-sheet__illo"
                        src={"https://aifs360.mybluemix.net/fslogo.png"}
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
        <InfoSection heading="The Ingredients" className="fact-sheet__r3">
          <InfoCard
            heading="IBM Federated&nbsp;Learning"
            body="The IBM Federated Learning Framework TODO: Text, link, icon"
            icon={<>IBM</>}
          />
          <InfoCard
            heading="fortiss Evidentia"
            body={<><a href="https://fortiss.org">fortiss</a> develops the
            Evidentia platform. TODO: Text"</>}
            icon={<img width="100px" style={{ marginLeft: "-15px" }} src="https://www.fortiss.org/fileadmin/user_upload/Veroeffentlichungen/Informationsmaterialien/Logo_fortiss_RGB_blue.png" />}
          />
          <InfoCard
            heading="MUSKETEER"
            body={<>The <a href="https://musketeer.eu/">MUSKETEER project</a>{" "}
            creates a validated, federated, privacy-preserving machine learning
            platform tested on industrial data that is inter-operable, scalable
            and efficient enough to be deployed in real use cases.</>}
            icon={<img width="120px" src="https://i2.wp.com/musketeer.eu/wp-content/uploads/2019/02/cropped-MUSKETEER_logo_RGB_2.jpg?w=2481&ssl=1" />}
          />
        </InfoSection>
      </div>
    );
  }
}

export default FactSheet
