package db

import (
	"context"
	"database/sql"
	"testing"
	"time"

	"github.com/stretchr/testify/require"
)

func TestCreateUser(t *testing.T) {
	arg := CreateUserParams{
		FirstName:   "Fake",
		MiddleName:  sql.NullString{String: "Middle", Valid: true},
		LastName:    "Last Name",
		DateOfBirth: time.Now(),
	}
	user, err := testQueries.CreateUser(context.Background(), arg)
	require.NoError(t, err)
	require.NotEmpty(t, user)
	require.Equal(t, user.FirstName, arg.FirstName)
	require.Equal(t, user.MiddleName, arg.MiddleName)
	require.Equal(t, user.LastName, arg.LastName)
	require.NotZero(t, user.ID)
}
