import React from 'react';
import {
  DataTable, Table, TableHeader, TableHead, TableRow, TableBody, TableCell,
  TableExpandHeader, TableExpandRow, TableExpandedRow
} from 'carbon-components-react';
import { Instances, ClaimOk, ClaimFail, getFirstCN, getOU, jsonOfConstant, } from '../../evidentia';

const sentModelTableHeader = [
  {
    header: 'Aggregator',
    key: 'aggregator',
  },
  {
    header: 'SHA-512 Hash',
    key: 'xsum',
  },
  {
    header: 'MUSKETEER key',
    key: 'key',
  }

];

const SentModelTable = props =>
  <Instances db={props.db}
    symbol="musketeer_sent_model"
    empty={<>Data on sent models is still missing.<ClaimFail /></>}>
    {claims => {
      const records = {};
      const data = claims.map(claim => {
        const record = jsonOfConstant(claim.args[0])
        records[record.key] = record;
        return {
          id: record.key,
          aggregator: record.aggregator,
          xsum: record.xsum.substring(0, 30) + "...",
          key: record.key.substring(0, 30) + "..."
        }
      });
      console.log(data);
      return <DataTable rows={data} headers={sentModelTableHeader}>
        {({
          rows,
          headers,
          getHeaderProps,
          getRowProps,
          getTableProps,
        }) => (
          <Table {...getTableProps()} isSortable>
            <TableHead>
              <TableRow>
                <TableExpandHeader />
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
                <React.Fragment key={row.id}>
                  <TableExpandRow key={row.id} {...getRowProps({ row })}>
                    {row.cells.map((cell) => (
                      <TableCell key={cell.id}>{cell.value}</TableCell>
                    ))}
                  </TableExpandRow>
                  <TableExpandedRow colSpan={headers.length + 1}
                    className="demo-expanded-td">
                    <h4 className="fact-sheet__subsubheading">
                      Full SHA-512 hash
                    </h4>
                    <div style={{ wordBreak: "break-all" }}>
                      {records[row.id].xsum}
                    </div>
                    <h4 className="fact-sheet__subsubheading">
                      Full Musketeer key
                    </h4>
                    <div style={{ wordBreak: "break-all" }}>
                      {records[row.id].key}
                    </div>
                  </TableExpandedRow>
                </React.Fragment>
              ))}
            </TableBody>
          </Table>
        )}
      </DataTable>
    }}
  </Instances >

const modelUpdatesTableHeader = [
  {
    header: 'Party',
    key: 'party',
  },
  {
    header: 'SHA-512 Hash',
    key: 'xsum',
  },
  {
    header: 'MUSKETEER key',
    key: 'key',
  }

];


const ModelUpdatesTable = props =>
  <Instances db={props.db}
    symbol="musketeer_party_model_update"
    empty={<>Data on party model update storage is still missing.<ClaimFail /></>}>
    {claims => {
      const records = {};
      const data = claims.map(claim => {
        const record = jsonOfConstant(claim.args[0])
        records[record.key] = record;
        return {
          id: record.key,
          party: record.party,
          xsum: record.xsum.substring(0, 30) + "...",
          key: record.key.substring(0, 30) + "..."
        }
      });
      console.log(data);
      return <DataTable rows={data} headers={modelUpdatesTableHeader}>
        {({
          rows,
          headers,
          getHeaderProps,
          getRowProps,
          getTableProps,
          getTableContainerProps,
        }) => (
          <Table {...getTableProps()} isSortable>
            <TableHead>
              <TableRow>
                <TableExpandHeader />
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
                <React.Fragment key={row.id}>
                  <TableExpandRow key={row.id} {...getRowProps({ row })}>
                    {row.cells.map((cell) => (
                      <TableCell key={cell.id}>{cell.value}</TableCell>
                    ))}
                  </TableExpandRow>
                  <TableExpandedRow colSpan={headers.length + 1}
                    className="demo-expanded-td">
                    <h4 className="fact-sheet__subsubheading">
                      Full SHA-512 hash
                    </h4>
                    <div style={{ wordBreak: "break-all" }}>
                      {records[row.id].xsum}
                    </div>
                    <h4 className="fact-sheet__subsubheading">
                      Full Musketeer key
                    </h4>
                    <div style={{ wordBreak: "break-all" }}>
                      {records[row.id].key}
                    </div>
                  </TableExpandedRow>
                </React.Fragment>
              ))}
            </TableBody>
          </Table>
        )}
      </DataTable>
    }}
  </Instances >


const MusketeerSection = props =>
  <>
    <h2 id="musketeer" className="fact-sheet__subheading">
      Model Lineage
    </h2>

    <p className="fact-sheet__p">
      The MUSKETEER plugin has recorded the following data about model
      updates that have been sent by the participants. The key identifies
      the storage location, where the model update is stored. It can be used
      by an auditor to retrieve the model update data that is needed to
      reproduce the claims of the parties about the learning steps.
    </p>

    <ModelUpdatesTable db={props.db} />

    <p className="fact-sheet__p">
      Similarly, MUSKETEER has recorded the identities and locations of
      the models that were distributed by aggregators.
    </p>

    <SentModelTable db={props.db} />


  </>


export { MusketeerSection }