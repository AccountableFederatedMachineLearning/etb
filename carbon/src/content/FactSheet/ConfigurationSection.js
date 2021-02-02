import React from 'react';
import {
  UnorderedList,
  CodeSnippet,
  ListItem,
  DataTable, Table, TableHeader, TableHead, TableRow, TableBody, TableCell
} from 'carbon-components-react';
import { Instances, ClaimOk, ClaimFail, jsonOfConstant } from '../../evidentia';

const configTableHeader = [
  {
    header: 'Option',
    key: 'option',
  },
  {
    header: 'Value',
    key: 'value',
  }
];

const ConfigTable = props =>
  <Instances db={props.db}
    symbol="configuration"
    principal="aggregator"
    empty={<>Hyper-parameter information is (still) missing.<ClaimFail /></>}>
    {claims =>
      claims.map(claim => {
        let config = jsonOfConstant(claim.args[0]);
        if (config?.hyperparams.global === undefined) {
          return null;
        } else {
          const data = [
            {
              id: '1',
              option: 'Maximum timeout',
              value: <>{config.hyperparams.global.max_timeout}<ClaimOk claim={claim} /></>
            },
            {
              id: '2',
              option: 'Number of parties',
              value: <>{config.hyperparams.global.parties}<ClaimOk claim={claim} /></>
            },
            {
              id: '3',
              option: 'Number of rounds',
              value: <>{config.hyperparams.global.rounds}<ClaimOk claim={claim} /></>
            },
            {
              id: '4',
              option: 'Termination accuracy',
              value: <>{config.hyperparams.global.termination_accuracy}<ClaimOk claim={claim} /></>
            },
          ];
          return <DataTable rows={data} headers={configTableHeader} key={JSON.stringify(claim)}>
            {({
              rows,
              headers,
              getHeaderProps,
              getRowProps,
              getTableProps,
              getTableContainerProps,
            }) => (
              // <TableContainer
              //   title="Configuration"
              //   description="Important configuration parameters of aggregator"
              //   {...getTableContainerProps()}>
              <Table {...getTableProps()} isSortable>
                <TableHead>
                  <TableRow>
                    {headers.map((header) => (
                      <TableHeader
                        key={header.key}
                        {...getHeaderProps({ header })}
                        isSortable>
                        {header.header}
                      </TableHeader>
                    ))}
                  </TableRow>
                </TableHead>
                <TableBody>
                  {rows.map((row) => (
                    <TableRow key={row.id} {...getRowProps({ row })}>
                      {row.cells.map((cell) => (
                        <TableCell key={cell.id}>{cell.value}</TableCell>
                      ))}
                    </TableRow>
                  ))}
                </TableBody>
              </Table>
              // </TableContainer>
            )}
          </DataTable>
        }
      })}
  </Instances>


const ConfigurationSection = props =>
  <>
    <h2 id="configuration" className="fact-sheet__subheading">
      Configuration
                        </h2>

    <p className="fact-sheet__p">
      The aggregator performs coordinates the learning process. It has recorded
      the following hyper-parameters of the training process.
                      </p>

    <p className="fact-sheet__p">
      <Instances db={props.db}
        symbol="configuration"
        principal="aggregator"
        empty={<>Information about the fusion algorithm it (still) missing.<ClaimFail /></>}>
        {claims =>
          claims.map(claim => {
            let config = jsonOfConstant(claim.args[0]);
            if (config.fusion.cls_ref === undefined) {
              return null;
            } else {
              return <React.Fragment key={JSON.stringify(claim)}>
                The fusion algorithm used by the aggregator was '<tt>{config.fusion.cls_ref}</tt>'.
                                  <ClaimOk claim={claim} />
              </React.Fragment>
            }
          })}
      </Instances>
    </p>

    <h3 className="fact-sheet__subsubheading">Global Hyper-Parameters</h3>

    <p className="fact-sheet__p">
      The aggregator's global hyper-parameters include the following settings:
                      </p>

    <ConfigTable db={props.db} />

    <p className="fact-sheet__p"></p>

    <h3 className="fact-sheet__subsubheading">Local Hyper-Parameters</h3>
    <p className="fact-sheet__p">
      The aggregator's local hyper-parameters include the following settings:
                      </p>
    <Instances db={props.db}
      symbol="configuration"
      principal="aggregator"
      empty={<>Information about local hyper-parameters is (still) missing.<ClaimFail /></>}>
      {claims =>
        claims.map(claim => {
          let config = jsonOfConstant(claim.args[0]);
          if (config.hyperparams === undefined || config.hyperparams.local === undefined) {
            return null;
          } else {
            return <React.Fragment key={JSON.stringify(claim)}>
              <UnorderedList>
                <ListItem>Optimizer options: <ClaimOk claim={claim} />
                  <CodeSnippet type="single" hideCopyButton={true}>
                    {JSON.stringify(config.hyperparams.local.optimizer)}
                  </CodeSnippet>
                </ListItem>
                <ListItem>Training options: <ClaimOk claim={claim} />
                  <CodeSnippet type="single" hideCopyButton={true}>
                    {JSON.stringify(config.hyperparams.local.training)}
                  </CodeSnippet>
                </ListItem>
              </UnorderedList>
            </React.Fragment>
          }
        })}
    </Instances>
    <p className="fact-sheet__p"></p>
  </>

export { ConfigurationSection }