/*
 * SPDX-License-Identifier: Apache-2.0
 */

package org.hyperledger.fabric.samples.assettransfer;

import com.owlike.genson.annotation.JsonProperty;
import org.hyperledger.fabric.contract.annotation.DataType;
import org.hyperledger.fabric.contract.annotation.Property;

import java.util.Objects;

@DataType()
public final class ClaimEvent {

  @Property()
  private final String subjectID;

  @Property()
  private final String issuerID;

  @Property()
  private final String claim;

  public String getSubjectID() {
    return subjectID;
  }

  public String getIssuerID() {
    return issuerID;
  }

  public String getClaim() {
    return claim;
  }

  public ClaimEvent(@JsonProperty("subject") final String subjectID,
                    @JsonProperty("issuerID") final String issuerID,
                    @JsonProperty("claim") final String claim) {
    this.subjectID = Objects.requireNonNull(subjectID);
    this.issuerID = Objects.requireNonNull(issuerID);
    this.claim = Objects.requireNonNull(claim);
  }

  @Override
  public boolean equals(final Object o) {
    if (this == o) {
      return true;
    }
    if (o == null || getClass() != o.getClass()) {
      return false;
    }
    ClaimEvent that = (ClaimEvent) o;
    return subjectID.equals(that.subjectID)
            && issuerID.equals(that.issuerID)
            && claim.equals(that.claim);
  }

  @Override
  public int hashCode() {
    return Objects.hash(subjectID, issuerID, claim);
  }

  @Override
  public String toString() {
    final StringBuilder sb = new StringBuilder("ClaimEvent{");
    sb.append("subjectID='").append(subjectID).append('\'');
    sb.append(", issuerID='").append(issuerID).append('\'');
    sb.append(", claim='").append(claim).append('\'');
    sb.append('}');
    return sb.toString();
  }
}
