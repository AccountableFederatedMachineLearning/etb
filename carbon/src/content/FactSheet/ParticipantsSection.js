import React from 'react';
import {
  UnorderedList,
  CodeSnippet,
  ListItem,
  DataTable, TableContainer, Table, TableHeader, TableHead, TableRow, TableBody, TableCell
} from 'carbon-components-react';
import { Instances, ClaimOk, ClaimFail, jsonOfConstant, getFirstCN, getOU } from '../../evidentia';

const configTableHeader = [
  {
    header: 'Common Name',
    key: 'cn',
  },
  {
    header: 'Organisational Unit(s)',
    key: 'ou',
  }
];

const ParticipantsTable = props =>
  <Instances db={props.db}
    symbol="configuration"
    empty={<>Hyper-parameter information is (still) missing.<ClaimFail /></>}>
    {claims => {
      const data = claims.map(claim =>
      ({
        id: getFirstCN(claim.principal.subject),
        cn: getFirstCN(claim.principal.subject),
        ou: <>{getOU(claim.principal.subject)}
          <ClaimOk claim={claim} /></>
      }));
      return <DataTable rows={data} headers={configTableHeader}>
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
        )}
      </DataTable>
    }}
  </Instances>


const ParticipantsSection = props =>
  <>
    <h2 id="participants" className="fact-sheet__subheading">
      Participants
                      </h2>

    <p className="fact-sheet__p">
      The following parties have participated in the learning process:
    </p>

    <ParticipantsTable db={props.db} />

    <p className="fact-sheet__p">
      In the rest of this factsheet, we refer to participants by their
      common name.
    </p>

  </>


export { ParticipantsSection }