// import * as React from "react"
import { Box, Typography } from '@mui/material'

export default function Dashboard() {
    return (
        <Box
            sx={{
                py: 5,
                position: 'relative',
                display: 'flex',
                flexDirection: 'column',
                alignItems: 'center',
                textAlign: 'center'
            }}>
                <Box>
                    <Typography variant="h4">Dashboard</Typography>
                </Box>
        </Box>
    )
}